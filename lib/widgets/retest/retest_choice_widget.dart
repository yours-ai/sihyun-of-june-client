import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/common/modal/modal_choice_widget.dart';
import 'package:project_june_client/widgets/common/modal/modal_widget.dart';

import '../../actions/auth/queries.dart';
import '../../constants.dart';
import '../../services/transaction_service.dart';

class RetestChoiceWidget extends ConsumerWidget {
  final bool inModal;
  final Function(String) onRetest;
  final Map<String, dynamic>? extendCost;

  const RetestChoiceWidget({
    super.key,
    this.inModal = false,
    required this.onRetest,
    this.extendCost,
  });

  static const int _RETEST_COIN_COST = 50;
  static const int _RETEST_POINT_COST = 300;

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

  void showSelectGoodsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ModalWidget(
        title: '어떤 재화를 사용하시겠어요?',
        choiceColumn: Column(
          children: [
            FilledButton(
              onPressed: () {
                onRetest('coin');
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
                    extendCost == null
                        ? _RETEST_COIN_COST.toString() + '코인'
                        : extendCost!['coin'].toString() + '코인',
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
              height: 13,
            ),
            FilledButton(
              onPressed: () {
                onRetest('point');
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
                    extendCost == null
                        ? _RETEST_POINT_COST.toString() + 'P'
                        : extendCost!['point'].toString() + 'P',
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
      query: getRetrieveMeQuery(),
      builder: (context, state) {
        if (state.data == null) {
          return const SizedBox.shrink();
        }
        PurchaseState purchaseState = transactionService.getPurchaseState(
          state.data!.coin,
          state.data!.point,
          extendCost == null ? _RETEST_COIN_COST : extendCost!['coin'],
          extendCost == null ? 300 : extendCost!['point'],
        );
        return ModalChoiceWidget(
          submitText: '좋아요',
          cancelText: '아니요',
          onSubmit: () {
            switch (purchaseState) {
              case PurchaseState.coin:
                onRetest('coin');
                break;
              case PurchaseState.point:
                onRetest('point');
                break;
              case PurchaseState.both:
                showSelectGoodsModal(context);
                break;
              case PurchaseState.impossible:
                showNeedMoreGoodsModal(context);
                break;
            }
          },
          onCancel: () {
            context.pop();
          },
          submitSuffix: extendCost == null
              ? '${_RETEST_POINT_COST}P 또는 $_RETEST_COIN_COST코인'
              : '${extendCost!['point']}P 또는 ${extendCost!['coin']}코인',
        );
      },
    );
  }
}
