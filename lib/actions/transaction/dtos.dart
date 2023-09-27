import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

@immutable
class StoreInfoDTO {
  late  bool isAvailable;
  late  List<ProductDetails> products;
  final List<PurchaseDetails> purchases;
  late  List<String> consumables;
  final bool purchasePending;
  late  bool loading;
  late  String? queryProductError;

  StoreInfoDTO({
    this.isAvailable = false,
    this.products = const <ProductDetails>[],
    this.purchases = const <PurchaseDetails>[],
    this.consumables = const <String>[],
    this.purchasePending = false,
    this.loading = true,
    this.queryProductError,
  });
}