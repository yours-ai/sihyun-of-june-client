import 'dart:io';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:project_june_client/actions/transaction/dtos.dart';

import '../../services.dart';
import '../../services/transaction_service.dart';
import 'actions.dart';
import 'models/CoinLog.dart';

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

Query<List<CoinLog>> getCoinLogsQuery({OnQueryErrorCallback? onError}) {
  return Query<List<CoinLog>>(
    key: 'coin-logs',
    queryFn: getCoinLogs,
    onError: onError,
  );
}

const List<String> kProductIds = <String>[
  'purchase_10_coins',
  'purchase_50_coins',
  'purchase_100_coins',
];

Query<List<Map<String, dynamic>>> getStoreInfoQuery({
  OnQueryErrorCallback? onError,
}) {
  return Query(
    key: 'store-info',
    queryFn: () async {
      var detailsList =
          await initStoreInfo(kProductIds, InAppPurchase.instance);
      return detailsList
          .map<Map<String, dynamic>>(
              (details) => transactionService.productDetailsToJson(details))
          .toList();
    },
    onError: onError,
  );
}
