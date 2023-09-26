import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

class ProductWidget extends StatefulWidget {
  final List<ProductDetails> products;
  final InAppPurchase inAppPurchase;
  final String kConsumableId;

  ProductWidget({Key? key, required this.products, required this.inAppPurchase, required this.kConsumableId}) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  static const ListTile productHeader = ListTile(
    title: Text('코인 구매하기'),
  );

  final List<ListTile> productList = <ListTile>[];

  @override
  Widget build(BuildContext context) {
    productList.addAll(widget.products.map((ProductDetails productDetails) {
      return ListTile(
        onTap: () {
          late PurchaseParam purchaseParam;

          if (Platform.isAndroid) {
            purchaseParam = GooglePlayPurchaseParam(
              productDetails: productDetails,
            );
          } else {
            purchaseParam = PurchaseParam(
              productDetails: productDetails,
            );
          }

          if (productDetails.id == widget.kConsumableId) {
            widget.inAppPurchase.buyConsumable(
                purchaseParam: purchaseParam);
          } else {
            widget.inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
          }
        },
        title: Text(productDetails.title),
        subtitle: Text(productDetails.description),
        trailing: Text(productDetails.price),
      );
    }));
    return Card(child: Column(children: <Widget>[productHeader] + productList));
  }
}
