import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/dtos.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/globals.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/common/back_appbar.dart';
import 'package:project_june_client/widgets/common/create_snackbar.dart';
import 'package:project_june_client/widgets/common/modal/modal_choice_widget.dart';
import 'package:project_june_client/widgets/common/modal/modal_widget.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';

class AssignmentDecideMethodScreen extends ConsumerStatefulWidget {
  const AssignmentDecideMethodScreen({super.key});

  @override
  AssignmentDecideMethodScreenState createState() {
    return AssignmentDecideMethodScreenState();
  }
}

class AssignmentDecideMethodScreenState
    extends ConsumerState<AssignmentDecideMethodScreen> {
  bool isEnableToClick = true;

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
            context.push('${TabRoutePaths.all}/my-coin/charge');
          },
          onSubmit: () {
            context.pop();
            context.push('${TabRoutePaths.all}/share');
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ReallocateDTO makeReallocateDto(String payment) {
      if (payment == 'coin') {
        return ReallocateDTO(
          method: 'character_selection',
          payment: payment,
        );
      } else {
        return ReallocateDTO(
          method: 'character_test',
          payment: payment,
        );
      }
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
          actions: MutationBuilder(
            mutation: getReallocateMutation(
              onSuccess: (res, arg) {
                scaffoldMessengerKey.currentState?.showSnackBar(
                  createSnackBar(
                    snackBarText:
                        transactionService.getPurchaseStateText(arg.payment),
                    characterColors: ColorTheme.defaultTheme.colors!,
                  ),
                );
                context.go('/assignment');
              },
              onError: (arg, error, fallback) {
                setState(() {
                  isEnableToClick = true;
                });
                showNeedMoreGoodsModal(context);
              },
            ),
            builder: (context, state, mutate) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FilledButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(isEnableToClick
                          ? ColorConstants.pink
                          : Color(ColorTheme.defaultTheme.colors!.secondary!)),
                    ),
                    onPressed: () {
                      if (isEnableToClick) {
                        setState(() {
                          isEnableToClick = false;
                        });
                        mutate(makeReallocateDto('point')); // 결제
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '누구든 괜찮아요',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeightConstants.semiBold,
                            height: 1.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Text(
                            '100P',
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
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  FilledButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(isEnableToClick
                          ? ColorConstants.pink
                          : Color(ColorTheme.defaultTheme.colors!.secondary!)),
                    ),
                    onPressed: () {
                      if (isEnableToClick) {
                        setState(() {
                          isEnableToClick = false;
                        });
                        mutate(makeReallocateDto('coin')); // 결제
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '원하는 상대로 해주세요',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeightConstants.semiBold,
                            height: 1.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Text(
                            '50코인',
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
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
