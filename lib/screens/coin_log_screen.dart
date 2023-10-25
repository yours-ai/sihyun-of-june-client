import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import '../actions/transaction/queries.dart';
import '../constants.dart';
import '../widgets/coinLog_wiget.dart';
import '../widgets/common/title_layout.dart';

class CoinLogScreen extends StatefulWidget {
  const CoinLogScreen({super.key});

  @override
  State<CoinLogScreen> createState() => _CoinLogScreenState();
}

class _CoinLogScreenState extends State<CoinLogScreen> {
  @override
  Widget build(context) {
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
        child: TitleLayout(
          withAppBar: true,
          titleText: '코인 내역',
          body: QueryBuilder(
              query: getCoinLogsQuery(),
              builder: (context, state) {
                return ListView(
                  children: state.data
                          ?.map<Widget>(
                              (coinLog) => CoinLogWidget(coinLog: coinLog))
                          .toList() ??
                      [],
                );
              }),
        ),
      ),
    );
  }
}
