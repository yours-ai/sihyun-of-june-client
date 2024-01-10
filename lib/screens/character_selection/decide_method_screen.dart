import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/actions/character/dtos.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/actions/notification/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/providers/user_provider.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/character/not_chosen_list_widget.dart';
import 'package:project_june_client/widgets/common/back_appbar.dart';
import 'package:project_june_client/widgets/common/modal/modal_choice_widget.dart';
import 'package:project_june_client/widgets/common/modal/modal_widget.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';

class CharacterSelectionDecideMethodScreen extends ConsumerWidget {
  final int? beforeTestId;

  const CharacterSelectionDecideMethodScreen(this.beforeTestId, {super.key});

  void showNeedMoreGoodsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ModalWidget(
        title: '앗, 재화가 부족해요.',
        choiceColumn: ModalChoiceWidget(
          cancelText: '코인 구매하러 가기',
          submitText: '친구 초대하고 300P 받기',
          onCancel: () {
            context.pop();
            context.push('/my-coin/charge');
          },
          onSubmit: () {
            context.pop();
            context.push('/share');
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MutationBuilder<dynamic, dynamic> makePaymentButton({
      required String mainText,
      required String paymentText,
      required String payment,
      required bool isPossiblePay,
    }) {
      final ReallocateDTO reallocateDTO = ReallocateDTO(
        method: payment == 'coin' ? 'character_selection' : 'character_test',
        payment: payment,
      );
      return MutationBuilder(
        mutation: getRetestMutation(
          onSuccess: (res, arg) {
            context.go('/');
          },
        ),

        builder: (context, state, mutate) {
          return FilledButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  state.status != QueryStatus.loading
                      ? ColorConstants.pink
                      : Color(ColorTheme.defaultTheme.colors!.secondary!)),
            ),
            onPressed: () {
              if(!isPossiblePay){
                showNeedMoreGoodsModal(context);
                return;
              }
              if (state.status != QueryStatus.loading) {
                if(beforeTestId != null){
                  getDenyTestChoiceMutation().mutate(beforeTestId!); // 이전 테스트 거절
                }
                mutate(reallocateDTO); // 결제
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  mainText,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeightConstants.semiBold,
                    height: 1.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Text(
                    paymentText,
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorConstants.lightGray.withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                      height: 1.0,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: const BackAppbar(),
      body: SafeArea(
        child: TitleLayout(
          title: Text(
            '혹시\n원하는 상대가 있으신가요?',
            style: Theme.of(context).textTheme.titleLarge,
            softWrap: true,
            textAlign: TextAlign.center,
          ),
          body: const SizedBox(),
          actions: QueryBuilder(
            query: getRetrieveMeQuery(),
            builder: (context, state) {
              if (state.data == null) {
                return const SizedBox.shrink();
              }
              final isPossiblePayCoin = state.data!.coin >= 50;
              final isPossiblePayPoint = state.data!.point >= 100;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  makePaymentButton(
                    mainText: '누구든 괜찮아요',
                    paymentText: '100P',
                    payment: 'point',
                    isPossiblePay: isPossiblePayPoint,
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  makePaymentButton(
                    mainText: '원하는 상대로 해주세요',
                    paymentText: '50코인',
                    payment: 'coin',
                      isPossiblePay: isPossiblePayCoin,
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
