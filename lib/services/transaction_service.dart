import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:project_june_client/actions/transaction/dtos.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionService {
  Future<StoreInfoDTO> initStoreInfo(
      List<String> _kProductIds, _inAppPurchase, StoreInfoDTO infoDTO) async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      infoDTO.loading = false;
      infoDTO.isAvailable = isAvailable;
      return infoDTO;
    }

    // if (Platform.isIOS) {
    //   final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
    //   _inAppPurchase
    //       .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
    //   await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    //   //애플문서 보고 해야함
    // }

    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      infoDTO.queryProductError = productDetailResponse.error!.message;
      infoDTO.loading = false;
      infoDTO.products = productDetailResponse.productDetails;
      infoDTO.isAvailable = isAvailable;
      infoDTO.notFoundIds = productDetailResponse.notFoundIDs;
      return infoDTO;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      infoDTO.queryProductError = null;
      infoDTO.isAvailable = isAvailable;
      infoDTO.products = productDetailResponse.productDetails;
      infoDTO.notFoundIds = productDetailResponse.notFoundIDs;
      infoDTO.loading = false;
      return infoDTO;
    }

    final List<String> consumables = await ConsumableStore.load();
    infoDTO.products = productDetailResponse.productDetails;
    infoDTO.notFoundIds = productDetailResponse.notFoundIDs;
    infoDTO.loading = false;
    infoDTO.consumables = consumables;
    return infoDTO;
  }


}

/// A store of consumable items.
///
/// This is a development prototype tha stores consumables in the shared
/// preferences. Do not use this in real world apps.
class ConsumableStore {
  static const String _kPrefKey = 'consumables';
  static Future<void> _writes = Future<void>.value();

  /// Adds a consumable with ID `id` to the store.
  ///
  /// The consumable is only added after the returned Future is complete.
  static Future<void> save(String id) {
    _writes = _writes.then((void _) => _doSave(id));
    return _writes;
  }

  /// Consumes a consumable with ID `id` from the store.
  ///
  /// The consumable was only consumed after the returned Future is complete.
  static Future<void> consume(String id) {
    _writes = _writes.then((void _) => _doConsume(id));
    return _writes;
  }

  /// Returns the list of consumables from the store.
  static Future<List<String>> load() async {
    return (await SharedPreferences.getInstance()).getStringList(_kPrefKey) ??
        <String>[];
  }

  static Future<void> _doSave(String id) async {
    final List<String> cached = await load();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    cached.add(id);
    await prefs.setStringList(_kPrefKey, cached);
  }

  static Future<void> _doConsume(String id) async {
    final List<String> cached = await load();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    cached.remove(id);
    await prefs.setStringList(_kPrefKey, cached);
  }
}
