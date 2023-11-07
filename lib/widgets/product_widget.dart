import 'dart:io';

import 'package:dotted_decoration/dotted_decoration.dart';
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
  final List<Container> productList = [];

  @override
  void initState() {
    super.initState();
  }

  var currencyFormatter = NumberFormat.currency(decimalDigits: 0, name: '');

  @override
  Widget build(BuildContext context) {
    if (productList.isEmpty) {
      productList.addAll(
        widget.kProductIds.map(
          (id) {
            var product = widget.products.firstWhere(
                (product) => product.id == id,
                orElse: () => widget.products.first);
            return Container(
              color: ColorConstants.lightGray,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      if (widget.isProcessing == false) {
                        widget.isProcessing = true;
                        setState(() {});
                        transactionService.initiatePurchase(
                            product, widget.inAppPurchase, widget.kProductIds);
                      }
                    },
                    title: Text(
                      Platform.isIOS
                          ? product.title
                          : product.title.substring(0, 9),
                      style: TextStyle(
                        fontSize: 18,
                        color: ColorConstants.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Text(
                      product.currencyCode == 'KRW'
                          ? (currencyFormatter.format(product.rawPrice) + '원')
                          : product.price.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        color: ColorConstants.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 28),
                    height: 2,
                    decoration: DottedDecoration(
                      shape: Shape.line,
                      linePosition: LinePosition.top,
                      color: ColorConstants.neutral,
                      dash: const [5, 5],
                      strokeWidth: 1,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
    return Column(children: productList);
  }
}
