import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:project_june_client/actions/transaction/dtos.dart';

import '../actions/transaction/actions.dart';

class TransactionService {
  Future<StoreInfoDTO> initStoreInfo(
      List<String> _kProductIds, _inAppPurchase, StoreInfoDTO infoDTO) async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      infoDTO.loading = false;
      infoDTO.isAvailable = isAvailable;
      return infoDTO;
    }

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      // await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
      //애플문서 보고 해야함
    }

    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(_kProductIds.toSet());

    if (productDetailResponse.error != null) {
      infoDTO.queryProductError = productDetailResponse.error!.message;
      infoDTO.loading = false;
      infoDTO.products = productDetailResponse.productDetails;
      infoDTO.isAvailable = isAvailable;
      return infoDTO;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      infoDTO.queryProductError = null;
      infoDTO.isAvailable = isAvailable;
      infoDTO.products = productDetailResponse.productDetails;
      infoDTO.loading = false;
      return infoDTO;
    }

    infoDTO.products = productDetailResponse.productDetails;
    infoDTO.loading = false;
    return infoDTO;
  }

  Future<bool> verifyPurchase(PurchaseDetails purchaseDetails) async {
    try {
      if (Platform.isIOS) {
        appleTransactionVerify(
            purchaseDetails.purchaseID!);
      }
      //   else {
    //     googleTransactionVerify(
    //         purchaseDetails.verificationData.serverVerificationData!);
    //   }
    } catch (e) {
      return false;
    }
    return true;
  }
}
