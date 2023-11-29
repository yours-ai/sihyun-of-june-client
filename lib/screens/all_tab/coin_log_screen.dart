import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:project_june_client/widgets/common/back_appbar.dart';
import 'package:project_june_client/widgets/common/title_underline.dart';
import '../../actions/transaction/queries.dart';
import '../../widgets/coin_log_widget.dart';
import '../../widgets/common/title_layout.dart';

class CoinLogScreen extends StatefulWidget {
  const CoinLogScreen({super.key});

  @override
  State<CoinLogScreen> createState() => _CoinLogScreenState();
}

class _CoinLogScreenState extends State<CoinLogScreen> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: const BackAppbar(),
      body: SafeArea(
        child: TitleLayout(
          withAppBar: true,
          title: const Center(
            child: TitleUnderline(
              titleText: '코인 내역',
            ),
          ),
          body: QueryBuilder(
              query: getCoinLogsQuery(),
              builder: (context, state) {
                return state.data != null
                    ? state.data!.isNotEmpty
                        ? ListView(
                            children: state.data
                                    ?.map<Widget>((coinLog) =>
                                        CoinLogWidget(coinLog: coinLog))
                                    .toList() ??
                                [],
                          )
                        : const Column(
                            children: [
                              SizedBox(height: 16),
                              Text('구매 내역이 없습니다.'),
                            ],
                          )
                    : const SizedBox.shrink();
              }),
        ),
      ),
    );
  }
}
