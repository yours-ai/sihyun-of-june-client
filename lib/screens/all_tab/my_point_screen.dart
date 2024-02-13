import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/widgets/common/back_appbar.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/common/title_underline.dart';
import 'package:project_june_client/widgets/common/menu/menu_widget.dart';

import '../../actions/auth/queries.dart';
import '../../constants.dart';
import '../../services.dart';

class MyPointScreen extends StatelessWidget {
  const MyPointScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppbar(),
      body: SafeArea(
        child: QueryBuilder(
          query: fetchMeQuery(),
          builder: (context, state) {
            return state.data == null
                ? const SizedBox.shrink()
                : TitleLayout(
                    withAppBar: true,
                    title: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const TitleUnderline(titleText: '내 포인트'),
                              const SizedBox(height: 14),
                              Text(
                                '${transactionService.currencyFormatter.format(state.data!.point)} P',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstants.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    body: Column(
                      children: [
                        const SizedBox(height: 16),
                        MenuWidget(
                          onPressed: () {
                            context.push(RoutePaths.allMyPointCharge);
                          },
                          title: '포인트 전환하기',
                        ),
                        MenuWidget(
                          onPressed: () {
                            context.push(RoutePaths.allMyPointLog);
                          },
                          title: '포인트 내역',
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
