import 'dart:io';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:intl/intl.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/modal/modal_choice_widget.dart';
import 'package:project_june_client/widgets/common/modal/modal_widget.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:async_button_builder/async_button_builder.dart';
import '../actions/transaction/queries.dart';

enum PurchaseState { coin, point, both, impossible }

class TransactionService {
  bool purchaseUpdatedListener(BuildContext context,
      PurchaseDetails purchaseDetails, InAppPurchase inAppPurchase) {
    switch (purchaseDetails.status) {
      case PurchaseStatus.pending:
        _handlePendingTransaction(context, purchaseDetails);
        return true;
      case PurchaseStatus.error:
        _handleErrorTransaction(context, purchaseDetails.error!);
      case PurchaseStatus.canceled:
        _handleCancelTransaction(context, purchaseDetails, inAppPurchase);
      case PurchaseStatus.purchased:
        _handlePurchasedTransaction(context, purchaseDetails, inAppPurchase);
      default:
        return false;
    }
    return false;
  }

  final currencyFormatter = NumberFormat.currency(decimalDigits: 0, name: '');

  void _handlePendingTransaction(
      BuildContext context, PurchaseDetails purchaseDetails) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          '잠시만 기다려주세요...',
        ),
      ),
    );
  }

  void _handleCancelTransaction(BuildContext context,
      PurchaseDetails purchaseDetails, InAppPurchase inAppPurchase) {
    if (Platform.isIOS) {
      inAppPurchase.completePurchase(purchaseDetails);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          '결제가 취소되었어요.',
        ),
      ),
    );
  }

  void _handleErrorTransaction(BuildContext context, IAPError error) {
    Sentry.captureException(error);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          '결제 도중 에러가 발생했어요. 에러가 계속되면 고객센터로 문의주세요.',
        ),
      ),
    );
  }

  void _handlePurchasedTransaction(BuildContext context,
      PurchaseDetails purchaseDetails, InAppPurchase inAppPurchase) {
    verifyPurchaseMutation(
      onSuccess: (res, arg) {
        inAppPurchase.completePurchase(purchaseDetails);
        fetchChangedCoinData();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              '결제가 완료되었어요.',
            ),
          ),
        );
      },
    ).mutate(purchaseDetails);
  }

  PurchaseParam setPurchaseParam(ProductDetails productDetails) {
    late PurchaseParam purchaseParam =
        PurchaseParam(productDetails: productDetails);
    if (Platform.isAndroid) {
      purchaseParam = GooglePlayPurchaseParam(
        productDetails: productDetails,
      );
      return purchaseParam;
    } else {
      purchaseParam = PurchaseParam(
        productDetails: productDetails,
      );
      return purchaseParam;
    }
  }

  void initiatePurchase(
      ProductDetails productDetails, InAppPurchase inAppPurchase) async {
    final purchaseParam = setPurchaseParam(productDetails);
    if (kProductIds.contains(productDetails.id)) {
      inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
    } else {
      // 애초에 build 되지 않아서 사용되지 않는 로직.
      inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
    }
  }

  void fetchChangedCoinData() {
    CachedQuery.instance.refetchQueries(keys: ['retrieve-me', 'coin-logs']);
  }

  Map<String, dynamic> productDetailsToJson(ProductDetails details) {
    return {
      'id': details.id,
      'title': details.title,
      'description': details.description,
      'price': details.price,
      'currencyCode': details.currencyCode,
      'rawPrice': details.rawPrice,
    };
  }

  List<ProductDetails> productListFromJson(List<Map<String, dynamic>> json) {
    final defaultProductList = json
        .map((e) => ProductDetails(
              id: e['id'],
              title: e['title'],
              description: e['description'],
              price: e['price'],
              currencyCode: e['currencyCode'],
              rawPrice: e['rawPrice'],
            ))
        .toList();
    defaultProductList.sort((a, b) => a.rawPrice.compareTo(b.rawPrice));
    return defaultProductList;
  }

  PurchaseState getPurchaseState(
      int coin, int point, int coinPrice, int pointPrice) {
    if (coin >= coinPrice && point >= pointPrice) {
      return PurchaseState.both;
    } else if (coin >= coinPrice && point < pointPrice) {
      return PurchaseState.coin;
    } else if (coin < coinPrice && point >= pointPrice) {
      return PurchaseState.point;
    } else {
      return PurchaseState.impossible;
    }
  }

  String getPurchaseStateText(String userPayment) {
    return userPayment == 'coin' ? '50코인을 사용했어요!' : '100포인트를 사용했어요!';
  }

  void showChargeForReadMail(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return ModalWidget(
          title: '10일 이후부터는 편지를 읽기 위해서는\n5코인이 필요해요.', //TODO: n일, n코인 동적
          titleStyle: TextStyle(
            fontSize: 18,
            height: 28 / 18,
            fontWeight: FontWeightConstants.semiBold,
            letterSpacing: 0.5,
          ),
          choiceColumn: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AsyncButtonBuilder(
                  child: TextWithSuffix(
                    buttonText: '오늘의 편지 읽기',
                    suffixText: '5코인',
                  ),
                  onPressed: () async {
                    await Future.delayed(Duration(seconds: 1))
                        .then((_) => context.go(RoutePaths.between));
                  },
                  builder: (context, child, callback, buttonState) {
                    return FilledButton(
                      onPressed: callback,
                      child: child,
                    );
                  }),
              const SizedBox(
                height: 13,
              ),
              AsyncButtonBuilder(
                  child: TextWithSuffix(
                    buttonText: '이달의 편지 모두 읽기',
                    suffixText: '50코인',
                  ),
                  onPressed: () async {
                    await Future.delayed(Duration(seconds: 1));
                  },
                  builder: (context, child, callback, buttonState) {
                    return FilledButton(
                      onPressed: callback,
                      child: child,
                    );
                  }),
            ],
          ),
        );
      },
    );
  }
}
