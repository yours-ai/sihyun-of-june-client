import 'dart:io';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

import '../actions/transaction/queries.dart';

class TransactionService {
  void purchaseUpdatedListener(
      BuildContext context, PurchaseDetails purchaseDetails) {
    if (purchaseDetails.status == PurchaseStatus.pending) {
      _handlePendingTransaction(context, purchaseDetails);
    } else {
      if (purchaseDetails.status == PurchaseStatus.error) {
        _handleErrorTransaction(context, purchaseDetails);
      } else if (purchaseDetails.status == PurchaseStatus.purchased) {
        _handlePurchasedTransaction(context, purchaseDetails);
      }
    }
  }

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

  void _handleErrorTransaction(
      BuildContext context, PurchaseDetails purchaseDetails) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          '결제 도중 에러가 발생했어요. 에러가 계속되면 고객센터로 문의주세요.',
        ),
      ),
    );
  }

  void _handlePurchasedTransaction(
      BuildContext context, PurchaseDetails purchaseDetails) {
    verifyPurchaseMutation(
      onSuccess: (res, arg) {
        handleNewTransaction();
      },
    ).mutate(purchaseDetails);
  }

  PurchaseParam setPurchaseParam(ProductDetails productDetails) {
    late PurchaseParam purchaseParam =
        PurchaseParam(productDetails: productDetails);
    if (Platform.isAndroid) {
      return purchaseParam = GooglePlayPurchaseParam(
        productDetails: productDetails,
      );
    } else {
      return purchaseParam = PurchaseParam(
        productDetails: productDetails,
      );
    }
  }

  void initiatePurchase(ProductDetails productDetails,
      InAppPurchase inAppPurchase, String kConsumableId) {
    var purchaseParam = setPurchaseParam(productDetails);
    if (productDetails.id == kConsumableId) {
      inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
    } else {
      inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
    }
  }

  void handleNewTransaction() {
    CachedQuery.instance.refetchQueries(keys: ["retrieve-me"]);
  }
}
