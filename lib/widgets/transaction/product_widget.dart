import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/dotted_underline.dart';

import '../../services.dart';

class ProductWidget extends StatefulWidget {
  final ProductDetails product;
  final bool isProcessing;
  final InAppPurchase inAppPurchase;

  const ProductWidget({
    Key? key,
    required this.product,
    required this.isProcessing,
    required this.inAppPurchase,
  }) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  final currencyFormatter = transactionService.currencyFormatter;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.isProcessing) {
          transactionService.initiatePurchase(
              widget.product, widget.inAppPurchase);
        }
      },
      child: Container(
          color: widget.isProcessing
              ? ColorConstants.background
              : ColorConstants.veryLightGray,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 66,
                    padding: const EdgeInsets.only(left: 28),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      Platform.isIOS
                          ? widget.product.title
                          : widget.product.title.substring(0, 9),
                      style: TextStyle(
                        fontSize: 18,
                        color: ColorConstants.primary,
                        fontWeight: FontWeightConstants.semiBold,
                      ),
                    ),
                  ),
                  if (widget.isProcessing)
                    const CircularProgressIndicator.adaptive(),
                  Container(
                    padding: const EdgeInsets.only(right: 28),
                    child: Text(
                      widget.product.currencyCode == 'KRW'
                          ? ('${currencyFormatter.format(widget.product.rawPrice)}원')
                          : widget.product.price.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        color: ColorConstants.primary,
                        fontWeight: FontWeightConstants.semiBold,
                      ),
                    ),
                  ),
                ],
              ),
              const DottedUnderline(28),
            ],
          )),
    );
  }
}
