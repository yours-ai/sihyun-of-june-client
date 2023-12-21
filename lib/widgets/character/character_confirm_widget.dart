import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/models/CharacterColors.dart';
import 'package:project_june_client/actions/character/models/CharacterTheme.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/widgets/common/modal/modal_widget.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/common/modal/modal_choice_widget.dart';
import 'package:project_june_client/widgets/retest/retest_choice_widget.dart';

import '../../actions/character/dtos.dart';
import '../../constants.dart';
import '../../globals.dart';
import '../../screens/character_test/character_choice_screen.dart';
import '../../services.dart';
import '../common/create_snackbar.dart';

class CharacterConfirmWidget extends ConsumerWidget {
  final int testId;
  final int selectedCharacterId;
  final String name;
  final TestReason testReason;
  final void Function(ActiveScreen) onActiveScreen;

  const CharacterConfirmWidget(
      {super.key,
      required this.onActiveScreen,
      required this.selectedCharacterId,
      required this.testId,
      required this.name,
      required this.testReason});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _showDenyModal() async {
      await showModalBottomSheet<void>(
        context: context,
        useRootNavigator: true,
        builder: (BuildContext context) {
          final mutation = getDenyTestChoiceMutation(
            onSuccess: (res, arg) {
              ref.read(characterThemeProvider.notifier).state =
                  ColorTheme.defaultTheme;
              if (arg.payment != 'new_user') {
                scaffoldMessengerKey.currentState?.showSnackBar(
                  createSnackBar(
                    snackBarText:
                        transactionService.getPurchaseStateText(arg.payment),
                    characterColors: ColorTheme.defaultTheme.colors!,
                  ),
                );
              }
              context.go('/character-test');
            },
          );
          return ModalWidget(
            title: '정말 다른 상대로 정해드릴까요?',
            choiceColumn: testReason == TestReason.retest
                ? MutationBuilder(
                    mutation: mutation,
                    builder: (context, state, mutate) {
                      void handleRetest(String payment) {
                        mutate(
                          denyTestChoiceDTO(id: testId, payment: payment),
                        );
                      }

                      return RetestChoiceWidget(
                        onRetest: handleRetest,
                      );
                    },
                  )
                : MutationBuilder(
                    mutation: mutation,
                    builder: (context, state, mutate) => ModalChoiceWidget(
                      submitText: '네',
                      submitSuffix: '신규 1회 무료',
                      onSubmit: () {
                        mutate(
                            denyTestChoiceDTO(id: testId, payment: 'new_user'));
                      },
                      cancelText: '됐어요',
                      onCancel: () => context.pop(),
                    ),
                  ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            onActiveScreen(ActiveScreen.detail);
          },
          icon: Container(
            padding: const EdgeInsets.only(left: 23),
            child: Icon(
              PhosphorIcons.arrow_left,
              color: ColorConstants.gray,
              size: 32,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: TitleLayout(
          withAppBar: true,
          title: Text(
            '$name이가 마음에 드세요?\n${mailService.getNextMailReceiveTimeStr()}에\n첫 '
            '편지가 올 거에요.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OutlinedButton(
                  onPressed: () {
                    _showDenyModal();
                  },
                  child: Text(
                    '다른 상대로 해주세요.',
                    style: TextStyle(
                      color: ColorConstants.gray,
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              MutationBuilder(
                mutation: getConfirmChoiceMutation(
                  onSuccess: (res, arg) {
                    characterService
                        .saveSelectedCharacterId(selectedCharacterId);
                    context.go('/');
                  },
                ),
                builder: (context, state, mutate) => FilledButton(
                  onPressed: () {
                    mutate(testId);
                  },
                  child: const Text(
                    '네',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Container(),
        ),
      ),
    );
  }
}
