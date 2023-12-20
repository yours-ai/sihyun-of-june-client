import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:project_june_client/widgets/common/back_appbar.dart';
import 'package:project_june_client/widgets/common/title_underline.dart';
import '../../actions/transaction/queries.dart';
import '../../widgets/transaction/transaction_log_widget.dart';
import '../../widgets/common/title_layout.dart';

class PointLogScreen extends StatefulWidget {
  const PointLogScreen({super.key});

  @override
  State<PointLogScreen> createState() => _PointLogScreenState();
}

class _PointLogScreenState extends State<PointLogScreen> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: const BackAppbar(),
      body: SafeArea(
        child: TitleLayout(
          withAppBar: true,
          title: const Center(
            child: TitleUnderline(
              titleText: '포인트 내역',
            ),
          ),
          body: QueryBuilder(
              query: getPointLogsQuery(),
              builder: (context, state) {
                return state.data != null && state.status == QueryStatus.success
                    ? state.data!.isNotEmpty
                        ? ListView(
                            children: state.data
                                    ?.map<Widget>(
                                        (pointLog) => TransactionLogWidget(
                                              transactionLog: pointLog,
                                              type: '포인트',
                                            ))
                                    .toList() ??
                                [],
                          )
                        : const Column(
                            children: [
                              SizedBox(height: 16),
                              Text('포인트 내역이 없습니다.'),
                            ],
                          )
                    : const SizedBox.shrink();
              }),
        ),
      ),
    );
  }
}
