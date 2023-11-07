import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import '../actions/transaction/queries.dart';
import '../constants.dart';
import '../widgets/coin_log_widget.dart';
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 6),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: ColorConstants.primary,
                      ),
                    ),
                  ),
                  child: Text(
                    "코인 내역",
                    style: Theme.of(context).textTheme.titleLarge,
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          body: QueryBuilder(
              query: getCoinLogsQuery(),
              builder: (context, state) {
                return state.data != null
                    ? state.data!.length > 0
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
