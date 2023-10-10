import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:project_june_client/constants.dart';

import '../services/transaction_service.dart';

class ProductWidget extends StatefulWidget {
  final List<ProductDetails> products;
  final InAppPurchase inAppPurchase;
  final String kConsumableId;

  ProductWidget(
      {Key? key,
      required this.products,
      required this.inAppPurchase,
      required this.kConsumableId})
      : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  static const ListTile productHeader = ListTile(
    title: Text('코인 추가로 구매하기', style: TextStyle(fontSize: 18)),
  );

  final List<ListTile> productList = <ListTile>[];
  var transactionService = TransactionService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (productList.isEmpty) {
      productList.addAll(widget.products.map((ProductDetails productDetails) {
        return ListTile(
          onTap: () {
            transactionService.initiatePurchase(
                productDetails, widget.inAppPurchase, widget.kConsumableId);
          },
          title: Text(
            Platform.isIOS
                ? productDetails.title
                : productDetails.title.substring(0, 9),
            style: TextStyle(color: ColorConstants.black, fontSize: 18),
          ),
          trailing: Text(
            productDetails.price,
            style: TextStyle(color: ColorConstants.black, fontSize: 18),
          ),
        );
      }));
    }
    return Card(child: Column(children: <Widget>[productHeader] + productList));
  }
}
