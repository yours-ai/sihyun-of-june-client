import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:project_june_client/actions/transaction/dtos.dart';

import '../client.dart';
import 'models/TransactionLog.dart';

Future<void> appleTransactionVerify(String purchaseID) async {
  await dio.post('/transaction/apple/transaction/', data: {
    'purchase_id': purchaseID,
  });
  return;
}

Future<void> googleTransactionVerify(GoogleVerificationDTO dto) async {
  await dio.post('/transaction/google/transaction/', data: {
    'order_id': dto.orderId,
    'product_id': dto.productId,
    'token': dto.purchaseToken,
  });
  return;
}

Future<List<ProductDetails>> initStoreInfo(
    List<String> productIds, InAppPurchase inAppPurchase) async {
  final ProductDetailsResponse response =
      await InAppPurchase.instance.queryProductDetails(productIds.toSet());
  return response.productDetails.toList();
}

Future<List<TransactionLog>> getCoinLogs() async {
  final response = await dio.get('/transaction/coin/logs/');
  return response.data
      .map<TransactionLog>((json) => TransactionLog.fromJson(json))
      .toList();
}

Future<List<TransactionLog>> getPointLogs() async {
  final response = await dio.get('/transaction/point/logs/');
  return response.data
      .map<TransactionLog>((json) => TransactionLog.fromJson(json))
      .toList();
}

Future<void> exchangeCoinToPoint(int coinAmount) async {
  await dio.post('/transaction/point/exchange/', data: {
    'coin_amount': coinAmount,
  });
  return;
}
