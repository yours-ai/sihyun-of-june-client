import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:project_june_client/actions/transaction/dtos.dart';

import '../client.dart';

Future<void> appleTransactionVerify(String purchaseID) async {
  await dio.post('/transaction/apple/transaction/', data: {
    'purchase_id': purchaseID,
  });
  return;
}

Future<void> googleTransactionVerify(String serverVerificationData) async {
  await dio.post('/transaction/google/transaction/', data: {
    'product_id': serverVerificationData,
    'token': serverVerificationData,
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
