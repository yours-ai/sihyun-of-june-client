import 'package:flutter/material.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/common/dotted_underline.dart';

import '../actions/transaction/models/TransactionLog.dart';
import '../constants.dart';

class TransactionLogWidget extends StatelessWidget {
  final TransactionLog transactionLog;
  final String type;

  const TransactionLogWidget(
      {Key? key, required this.transactionLog, required this.type})
      : super(key: key);

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
                transactionLog.description,
                style: TextStyle(
                  color: ColorConstants.primary,
                  fontWeight: FontWeightConstants.semiBold,
                  fontSize: 16,
                ),
              ),
            ),
            subtitle: Text(
              transactionLog.created.toString().substring(2, 10),
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
                Text(
                  '${transactionService.currencyFormatter
                      .format(transactionLog.amount)} $type',
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorConstants.primary,
                    fontWeight: FontWeightConstants.semiBold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${transactionService.currencyFormatter
                          .format(transactionLog.balance)} $type',
                  style: TextStyle(
                    color: ColorConstants.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
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
