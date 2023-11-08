import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/common/dotted_underline.dart';

import '../actions/transaction/models/CoinLog.dart';
import '../constants.dart';

class CoinLogWidget extends StatelessWidget {
  final CoinLog coinLog;

  const CoinLogWidget({Key? key, required this.coinLog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.lightGray,
      child: Column(
        children: [
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                coinLog.description,
                style: TextStyle(
                  color: ColorConstants.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            subtitle: Text(
              coinLog.created.toString().substring(2, 10),
              style: TextStyle(
                fontSize: 14,
                color: ColorConstants.primary,
                fontWeight: FontWeight.normal,
              ),
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      transactionService.currencyFormatter
                          .format(coinLog.amount)
                          .toString(),
                      style: TextStyle(
                        fontSize: 18,
                        color: ColorConstants.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      PhosphorIcons.coin_vertical,
                      color: ColorConstants.primary,
                      size: 18,
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      transactionService.currencyFormatter
                          .format(coinLog.balance)
                          .toString(),
                      style: TextStyle(
                        color: ColorConstants.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Icon(
                      PhosphorIcons.coin_vertical,
                      color: ColorConstants.primary,
                      size: 14,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const DottedUnderline(28),
        ],
      ),
    );
  }
}
