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
  final bool isExtend; // TODO - isExtend에 따라 나누기
  final bool inModal;

  const RetestChoiceWidget(
      {super.key, this.isExtend = false, this.inModal = false});

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
              height: 13,
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
    return Column(
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
          height: 13,
        ),
        QueryBuilder(
          query: getRetrieveMeQuery(),
          builder: (context, state) {
            if (state.data == null) {
              return const SizedBox.shrink();
            }
            PurchaseState purchaseState = transactionService.getPurchaseState(
              state.data!.coin,
              state.data!.point,
            );
            return FilledButton(
              onPressed: () {
                if (inModal) {
                  context.pop();
                }
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
    );
  }
}
