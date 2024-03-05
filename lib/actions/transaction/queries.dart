import 'dart:io';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:project_june_client/actions/transaction/dtos.dart';

import '../../services.dart';
import 'actions.dart';
import 'models/TransactionLog.dart';

Mutation<void, PurchaseDetails> verifyPurchaseMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, PurchaseDetails>(
    queryFn: (purchaseDetails) async {
      if (Platform.isIOS) {
        await verifyAppleTransaction(purchaseDetails.purchaseID!);
      } else {
        await verifyGoogleTransaction(
          GoogleVerificationDTO(
            orderId: purchaseDetails.purchaseID!,
            productId: purchaseDetails.productID,
            purchaseToken:
                purchaseDetails.verificationData.serverVerificationData,
          ),
        );
      }
    },
    onSuccess: onSuccess,
    onError: onError,
  );
}

Query<List<TransactionLog>> fetchCoinLogsQuery({OnQueryErrorCallback? onError}) {
  return Query<List<TransactionLog>>(
    key: 'coin-logs',
    queryFn: fetchCoinLogs,
    onError: onError,
  );
}

Query<List<TransactionLog>> fetchPointLogsQuery({OnQueryErrorCallback? onError}) {
  return Query<List<TransactionLog>>(
    key: 'point-logs',
    queryFn: fetchPointLogs,
    onError: onError,
  );
}

const List<String> kProductIds = <String>[
  'purchase_10_coins',
  'purchase_50_coins',
  'purchase_100_coins',
];

Query<List<Map<String, dynamic>>> fetchStoreInfoQuery({
  OnQueryErrorCallback? onError,
}) {
  return Query(
    key: 'store-info',
    queryFn: () async {
      final detailsList =
          await initStoreInfo(kProductIds, InAppPurchase.instance);
      return detailsList
          .map<Map<String, dynamic>>(
              (details) => transactionService.productDetailsToJson(details))
          .toList();
    },
    onError: onError,
  );
}

Mutation<void, int> exchangeCoinToPointMutation({
  refetchQueries = const [],
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, int>(
    refetchQueries: refetchQueries,
    queryFn: (coinAmount) async {
      await exchangeCoinToPoint(coinAmount);
    },
    onSuccess: onSuccess,
    onError: onError,
  );
}
