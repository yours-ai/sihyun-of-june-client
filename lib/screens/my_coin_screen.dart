import 'dart:async';
import 'dart:io';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:intl/intl.dart';
import 'package:project_june_client/actions/transaction/dtos.dart';
import 'package:project_june_client/actions/transaction/queries.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/menu_widget.dart';
import 'package:project_june_client/widgets/product_widget.dart';

import '../actions/auth/queries.dart';
import '../actions/transaction/actions.dart';
import '../constants.dart';
import '../services.dart';
import '../services/transaction_service.dart';

class MyCoinScreen extends StatelessWidget {
  MyCoinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Container(
            padding: const EdgeInsets.only(left: 23),
            child: Icon(
              PhosphorIcons.arrow_left,
              color: ColorConstants.black,
              size: 32,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: QueryBuilder(
          query: getRetrieveMeQuery(),
          builder: (context, state) {
            bool isProcessing = false;
            return state.data == null
                ? const SizedBox.shrink()
                : TitleLayout(
                    withAppBar: true,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Flexible(
                          child: Text(
                            '내 코인',
                            style: TextStyle(
                                fontFamily: 'NanumJungHagSaeng',
                                fontSize: 39,
                                height: 36 / 39),
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                                transactionService.currencyFormatter
                                    .format(state.data!.coin),
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 8),
                            Icon(
                              PhosphorIcons.coin_vertical,
                              color: ColorConstants.black,
                              size: 32,
                            ),
                          ],
                        ),
                      ],
                    ),
                    body: Column(
                      children: [
                        const SizedBox(height: 16),
                        MenuWidget(
                          onPressed: () {
                            context.push('/my-coin/charge');
                          },
                          title: '충전하기',
                        ),
                        MenuWidget(
                          onPressed: () {
                            context.push('/my-coin/log');
                          },
                          title: '코인 내역',
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
