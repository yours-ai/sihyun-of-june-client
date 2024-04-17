import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/transaction/queries.dart';
import 'package:project_june_client/widgets/common/back_appbar.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/common/title_underline.dart';
import 'package:project_june_client/widgets/common/menu/menu_widget.dart';

import '../../actions/auth/queries.dart';
import '../../constants.dart';
import '../../services.dart';
import '../../widgets/common/modal/modal_choice_widget.dart';
import '../../widgets/common/modal/modal_widget.dart';

class PointChangeScreen extends StatelessWidget {
  const PointChangeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _showChangeCoinToPointModal(int coin, int point) async {
      await showModalBottomSheet<void>(
        context: context,
        useRootNavigator: true,
        builder: (BuildContext context) {
          return MutationBuilder(
            mutation: exchangeCoinToPointMutation(
              refetchQueries: ['retrieve-me'],
              onSuccess: (res, arg) {
                context.pop();
              },
            ),
            builder: (context, state, mutate) => ModalWidget(
              title: '정말 $coin코인을 $point포인트로 \n전환하시겠어요?',
              choiceColumn: ModalChoiceWidget(
                submitText: '네',
                onSubmit: () async {
                  mutate(coin);
                },
                cancelText: '아니요',
                onCancel: () async => context.pop(),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: const BackAppbar(),
      body: SafeArea(
        child: QueryBuilder(
          query: fetchMeQuery(),
          builder: (context, state) {
            if (state.data == null) {
              return const SizedBox.shrink();
            } else {
              return TitleLayout(
                withAppBar: true,
                title: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Expanded(child: SizedBox()),
                              const TitleUnderline(titleText: '포인트 전환'),
                              Expanded(
                                child: Text(
                                  '${transactionService.currencyFormatter.format(state.data!.coin)} 코인\n보유중',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: ColorConstants.primary,
                                    fontWeight: FontWeightConstants.semiBold,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                        if (state.data!.coin < 10) {
                          transactionService.showNotEnoughCoinModal(context);
                          return;
                        }
                        _showChangeCoinToPointModal(10, 50);
                      },
                      titleWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '10코인',
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorConstants.primary,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              PhosphorIcons.arrow_circle_right,
                              color: ColorConstants.primary,
                              size: 24,
                            ),
                          ),
                          Text(
                            '50포인트',
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorConstants.primary,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
