import 'dart:io';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:project_june_client/actions/transaction/dtos.dart';

import 'actions.dart';

Mutation<void, PurchaseDetails> verifyPurchaseMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, PurchaseDetails>(
    queryFn: (purchaseDetails) async {
      if (Platform.isIOS) {
        await appleTransactionVerify(purchaseDetails.purchaseID!);
      } else {
        await googleTransactionVerify(
          GoogleVerificationDTO(
            orderId: purchaseDetails.purchaseID!,
            productId: purchaseDetails.productID,
            purchaseToken:
                purchaseDetails.verificationData.serverVerificationData,
          ),
        );
      }
      ;
    },
    onSuccess: onSuccess,
    onError: onError,
  );
}
