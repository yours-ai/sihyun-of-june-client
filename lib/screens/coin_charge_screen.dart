import 'dart:async';
import 'dart:io';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:project_june_client/actions/transaction/dtos.dart';
import 'package:project_june_client/actions/transaction/queries.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/menu_widget.dart';
import 'package:project_june_client/widgets/product_widget.dart';

import '../actions/auth/queries.dart';
import '../actions/transaction/actions.dart';
import '../constants.dart';
import '../services.dart';
import '../services/transaction_service.dart';

class CoinChargeScreen extends StatefulWidget {
  const CoinChargeScreen({Key? key}) : super(key: key);

  @override
  State<CoinChargeScreen> createState() => _CoinChargeScreenState();
}

class _CoinChargeScreenState extends State<CoinChargeScreen> {
  late StreamSubscription<List<PurchaseDetails>> _subscription;

  Future<void> handlePastTransactions() async {
    var transactions = await SKPaymentQueueWrapper().transactions();
    transactions.forEach((SKPaymentTransactionWrapper) {
      SKPaymentQueueWrapper().finishTransaction(SKPaymentTransactionWrapper);
    });
  }

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        InAppPurchase.instance.purchaseStream;
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    });
    handlePastTransactions();
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      transactionService.purchaseUpdatedListener(
          context, purchaseDetails, InAppPurchase.instance);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Container(
            padding: const EdgeInsets.only(left: 23),
            child: Icon(
              PhosphorIcons.arrow_left,
              color: ColorConstants.black,
              size: 32,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: QueryBuilder(
          query: getRetrieveMeQuery(),
          builder: (context, state) {
            bool isProcessing = false;
            return state.data == null
                ? const SizedBox.shrink()
                : TitleLayout(
                    withAppBar: true,
                    titleText: '충전하기',
                    titleAddOn: Row(
                      children: [
                        Text(transactionService.currencyFormatter.format(state.data!.coin),
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        Icon(
                          PhosphorIcons.coin_vertical,
                          color: ColorConstants.black,
                          size: 32,
                        ),
                      ],
                    ),
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          QueryBuilder(
                            query: getStoreInfoQuery(),
                            builder: (context, state) {
                              return state.data == null
                                  ? SizedBox.shrink()
                                  : ProductWidget(
                                      products: transactionService
                                              .productListFromJson(state.data!) ??
                                          [],
                                      inAppPurchase: InAppPurchase.instance,
                                      kProductIds: kProductIds,
                                      isProcessing: isProcessing,
                                    );
                            },
                          ),
                          const ExpansionTile(title: Text('코인 구매안내', style: TextStyle(fontSize: 18),), children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(28, 10, 28, 15),
                              child: Text(
                                "• 구매한 코인은 유월의 시현이에서만 사용하실 수 있습니다.\n• 이벤트로 받은 무료 코인은 구매 취소 및 환불 대상이 아닙니다.\n• Google Play 결제로 구매한 코인은 구매 후 48시간 이내는 Google Play 고객센터를 통해 환불이 가능합니다.\n• Google Play 결제로 구매한 쿠키의 구매내역은 'Google Play 스토어 앱>계정>결제 및 정기 결제>예산 및 기록'에서도 확인하실 수 있습니다.\n• iOS앱에서 구매한 코인의 구매취소는 App Store의 정책 상 Apple 고객센터 를 통해서만 가능합니다.\n• iOS앱에서 구매한 코인 구매내역은 'iOS설정>계정' 또는 'iTunes> 계정>나의 계정보기> 구입내역' 메뉴에서도 확인 가능합니다.",
                                style: TextStyle(height: 1.5),
                              ),
                            )
                          ]),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
