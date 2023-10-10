import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

@immutable
class StoreInfoDTO {
  late  bool isAvailable;
  late  List<ProductDetails> products;
  final List<PurchaseDetails> purchases;
  final bool purchasePending;
  late  bool loading;

  StoreInfoDTO({
    this.isAvailable = false,
    this.products = const <ProductDetails>[],
    this.purchases = const <PurchaseDetails>[],
    this.purchasePending = false,
    this.loading = true,
  });
}