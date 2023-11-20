import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:intl/intl.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/dotted_underline.dart';

import '../services.dart';

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
                    GestureDetector(
                      onTap: () {
                        if (widget.isProcessing == false) {
                          widget.isProcessing = true;
                          setState(() {});
                          transactionService.initiatePurchase(product,
                              widget.inAppPurchase, widget.kProductIds);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 66,
                            padding: const EdgeInsets.only(left: 28),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              Platform.isIOS
                                  ? product.title
                                  : product.title.substring(0, 9),
                              style: TextStyle(
                                fontSize: 18,
                                color: ColorConstants.primary,
                                fontWeight: FontWeightConstants.semiBold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 28),
                            child: Text(
                              product.currencyCode == 'KRW'
                                  ? ('${currencyFormatter.format(product.rawPrice)}원')
                                  : product.price.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                color: ColorConstants.primary,
                                fontWeight: FontWeightConstants.semiBold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const DottedUnderline(28),
                  ],
                ));
          },
        ),
      );
    }
    return Column(children: productList);
  }
}
