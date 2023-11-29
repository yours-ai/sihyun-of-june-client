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
import '../../widgets/common/modal/modal_choice_widget.dart';
import '../../widgets/common/modal/modal_widget.dart';

class PointChangeScreen extends StatelessWidget {
  const PointChangeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _showNotEnoughCoinModal() async {
      await showModalBottomSheet<void>(
        context: context,
        useRootNavigator: true,
        builder: (BuildContext context) {
          return ModalWidget(
            title: '앗, 코인이 부족해요 🥲',
            choiceColumn: ModalChoiceWidget(
              submitText: '코인 구매하러 가기',
              onSubmit: () {
                context.push('/my-coin/charge');
                context.pop();
              },
              cancelText: '확인',
              onCancel: () => context.pop(),
            ),
          );
        },
      );
    }

    void _showChangeCoinToPointModal(int coin, int point) async {
      await showModalBottomSheet<void>(
        context: context,
        useRootNavigator: true,
        builder: (BuildContext context) {
          return ModalWidget(
            title: '정말 ${coin}코인을 ${point}포인트로 \n전환하시겠어요?',
            choiceColumn: ModalChoiceWidget(
              submitText: '네',
              onSubmit: () {
                //TODO: 포인트로 변경, mutation이 되면 context.pop()으로 변경
                context.pop();
              },
              cancelText: '아니요',
              onCancel: () => context.pop(),
            ),
          );
        },
      );
    }

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
                              Row(
                                children: [
                                  const Expanded(child: SizedBox()),
                                  const TitleUnderline(titleText: '포인트 전환'),
                                  Expanded(
                                    child: Text(
                                      //TODO: 포인트로 변경
                                      '${transactionService.currencyFormatter
                                              .format(state.data!.coin)} 코인\n보유중',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: ColorConstants.primary,
                                          fontWeight:
                                              FontWeightConstants.semiBold,
                                          height: 1.2),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Text(
                                //TODO: 포인트로 변경
                                '${transactionService.currencyFormatter
                                        .format(state.data!.coin)} 포인트',
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
                            if (state.data!.coin * 5 >= 100) { // TODO-포인트로 변경
                              _showNotEnoughCoinModal();
                              return;
                            }
                            _showChangeCoinToPointModal(10, 50);
                          },
                          title: '50포인트',
                          suffix: Text(
                            '10코인',
                            style: TextStyle(
                              fontSize: 18,
                              color: ColorConstants.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
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
