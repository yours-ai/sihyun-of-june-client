import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:project_june_client/actions/transaction/dtos.dart';

import '../client.dart';
import 'models/CoinLog.dart';

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

Future<StoreInfoDTO> initStoreInfo(List<String> ProductIds,
    InAppPurchase inAppPurchase, StoreInfoDTO infoDTO) async {
  try {
    final ProductDetailsResponse productDetailResponse =
        await InAppPurchase.instance.queryProductDetails(ProductIds.toSet());
    infoDTO.products = productDetailResponse.productDetails;
  } catch (e) {
    infoDTO.isAvailable = false;
  }
  infoDTO.loading = false;
  return infoDTO;
}
