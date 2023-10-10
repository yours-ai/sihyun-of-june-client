import 'dart:io';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'actions.dart';

Mutation<void, PurchaseDetails> verifyPurchaseMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, PurchaseDetails>(
    queryFn: (purchaseDetails) async {
      if (Platform.isIOS) {
        appleTransactionVerify(purchaseDetails.purchaseID!);
      } else {
        // googleTransactionVerify(
        //     purchaseDetails.verificationData.serverVerificationData!);
      }
      ;
    },
    onSuccess: onSuccess,
    onError: onError,
  );
}
