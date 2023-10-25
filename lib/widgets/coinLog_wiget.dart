import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

import '../actions/transaction/models/CoinLog.dart';
import '../constants.dart';

class CoinLogWidget extends StatelessWidget {
  final CoinLog coinLog;

  const CoinLogWidget({Key? key, required this.coinLog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(coinLog.description)),
      subtitle: Text(coinLog.created.toString().substring(2, 10)),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                coinLog.amount.toString(),
                style: TextStyle(fontSize: 18),
              ),
              Icon(
                PhosphorIcons.coin_vertical,
                color: ColorConstants.black,
                size: 18,
              ),
            ],
          ),
          SizedBox(height: 3),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                coinLog.balance.toString(),
                style: TextStyle(color: ColorConstants.neutral, fontSize: 14),
              ),
              Icon(
                PhosphorIcons.coin_vertical,
                color: ColorConstants.neutral,
                size: 14,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
