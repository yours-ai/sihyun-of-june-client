import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:intl/intl.dart';
import 'package:project_june_client/constants.dart';

import '../services.dart';
import '../services/transaction_service.dart';

class ProductWidget extends StatefulWidget {
  final List<ProductDetails> products;
  final InAppPurchase inAppPurchase;
  final List<String> kProductIds;
  bool isProcessing;

  ProductWidget(
      {Key? key,
      required this.products,
      required this.inAppPurchase,
      required this.kProductIds,
      required this.isProcessing})
      : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  final List<ListTile> productList = <ListTile>[];

  @override
  void initState() {
    super.initState();
  }

  var currencyFormatter = NumberFormat.currency(decimalDigits: 0, name: '');

  @override
  Widget build(BuildContext context) {
    if (productList.isEmpty) {
      productList.addAll(widget.products.map((ProductDetails productDetails) {
        return ListTile(
          onTap: () {
            if (widget.isProcessing == false) {
              widget.isProcessing = true;
              setState(() {});
              transactionService.initiatePurchase(
                  productDetails, widget.inAppPurchase, widget.kProductIds);
            }
          },
          title: Text(
            Platform.isIOS
                ? productDetails.title
                : productDetails.title.substring(0, 9),
            style: TextStyle(color: ColorConstants.black, fontSize: 18),
          ),
          trailing: Text(
            productDetails.currencyCode == 'KRW'
                ? (currencyFormatter.format(productDetails.rawPrice) + '원')
                : productDetails.price.toString(),
            style: TextStyle(color: ColorConstants.black, fontSize: 18),
          ),
        );
      }));
    }
    return Column(children: productList);
  }
}
