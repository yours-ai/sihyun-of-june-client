import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/common/modal/modal_choice_widget.dart';
import 'package:project_june_client/widgets/common/modal/modal_description_widget.dart';
import 'package:project_june_client/widgets/common/modal/modal_widget.dart';

import '../actions/auth/queries.dart';
import '../constants.dart';
import '../providers/character_provider.dart';
import '../services/transaction_service.dart';

class RetestModalWidget extends ConsumerWidget {
  const RetestModalWidget({super.key});

  final bool hasTimeLeft = true; //대체될 예정

  void showNeedMoreGoodsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ModalWidget(
        title: '앗, 재화가 부족해요.',
        choiceColumn: ModalChoiceWidget(
          cancelText: '코인 구매하러 가기',
          submitText: '친구 초대하고 300P 받기',
          onCancel: () {
            context.push('/my-coin/charge');
          },
          onSubmit: () {
            context.push('/share');
          },
        ),
      ),
    );
  }

  void showSelectGoodsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ModalWidget(
        title: '어떤 재화를 사용하시겠어요?',
        choiceColumn: Column(
          children: [
            FilledButton(
              onPressed: () {
                context.pop();
                // TODO - 코인 사용
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '코인 사용',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeightConstants.semiBold,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    '50코인',
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorConstants.lightGray.withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            FilledButton(
              onPressed: () {
                context.pop();
                // TODO - 포인트 사용
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '포인트 사용',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeightConstants.semiBold,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    '300P',
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorConstants.lightGray.withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return QueryBuilder(
      query: getRetrieveMyCharacterQuery(),
      builder: (context, state) {
        if (state.data != null) {
          final selectedCharacter = state.data!
              .where((character) =>
                  character.id == ref.watch(selectedCharacterProvider))
              .first;
          return ModalWidget(
            title:
                '아직 ${selectedCharacter.first_name}이와의 시간이 남았어요.\n그래도 새 친구를 만나시겠어요?',
            description: ModalDescriptionWidget(
                description:
                    '${selectedCharacter.first_name}이와의 기억이 지워지고,\n더 이상 편지를 받아볼 수 없어요.'),
            choiceColumn: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ColorConstants.background),
                  ),
                  onPressed: () {
                    context.pop();
                  },
                  child: Text(
                    '아니요',
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorConstants.gray,
                      fontWeight: FontWeightConstants.semiBold,
                      height: 1.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                QueryBuilder(
                  query: getRetrieveMeQuery(),
                  builder: (context, state) {
                    if (state.data == null) {
                      return const SizedBox.shrink();
                    }
                    PurchaseState purchaseState =
                        transactionService.getPurchaseState(
                      state.data!.coin,
                      state.data!.point,
                    );
                    return FilledButton(
                      onPressed: () {
                        context.pop();
                        switch (purchaseState) {
                          case PurchaseState.coin:
                            // TODO - 코인 사용
                            break;
                          case PurchaseState.point:
                            // TODO - 포인트 사용
                            break;
                          case PurchaseState.both:
                            showSelectGoodsModal(context);
                            break;
                          case PurchaseState.impossible:
                            showNeedMoreGoodsModal(context);
                            break;
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '네',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeightConstants.semiBold,
                              height: 1.0,
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            '300P 또는 50코인',
                            style: TextStyle(
                              fontSize: 14,
                              color: ColorConstants.lightGray.withOpacity(0.5),
                              fontWeight: FontWeight.bold,
                              height: 1.0,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
