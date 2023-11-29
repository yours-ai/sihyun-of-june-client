import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/widgets/common/back_appbar.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/common/title_underline.dart';
import 'package:project_june_client/widgets/menu_widget.dart';

import '../../actions/auth/queries.dart';
import '../../constants.dart';
import '../../services.dart';

class MyCoinScreen extends StatelessWidget {
  const MyCoinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppbar(),
      body: SafeArea(
        child: QueryBuilder(
          query: getRetrieveMeQuery(),
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
                              const TitleUnderline(titleText: '내 코인'),
                              const SizedBox(height: 14),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    transactionService.currencyFormatter
                                        .format(state.data!.coin),
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstants.primary,
                                    ),
                                  ),
                                  Icon(
                                    PhosphorIcons.coin_vertical,
                                    color: ColorConstants.primary,
                                    size: 36,
                                  ),
                                ],
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
