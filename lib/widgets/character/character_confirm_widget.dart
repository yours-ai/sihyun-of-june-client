import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/widgets/common/modal/modal_widget.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/common/modal/modal_choice_widget.dart';
import '../../constants.dart';
import '../../globals.dart';
import '../../screens/character_test/character_choice_screen.dart';
import '../../services.dart';
import '../common/modal/modal_description_widget.dart';

class CharacterConfirmWidget extends ConsumerStatefulWidget {
  final int testId;
  final int selectedCharacterId;
  final String characterFirstName;
  final TestReason testReason;
  final void Function(ActiveScreen) onActiveScreen;

  const CharacterConfirmWidget(
      {super.key,
      required this.onActiveScreen,
      required this.selectedCharacterId,
      required this.testId,
      required this.characterFirstName,
      required this.testReason});

  @override
  CharacterConfirmWidgetState createState() {
    return CharacterConfirmWidgetState();
  }
}

class CharacterConfirmWidgetState
    extends ConsumerState<CharacterConfirmWidget> {
  bool isEnableToClick = true;

  @override
  Widget build(BuildContext context) {
    showDenyModal() async {
      await showModalBottomSheet<void>(
        context: context,
        useRootNavigator: true,
        builder: (BuildContext context) {
          return ModalWidget(
            title: '정말 다른 상대로 정해드릴까요?',
            description: const ModalDescriptionWidget(
              description: '다른 상대를 만나려면,\n추가로 재화를 사용하셔야 해요.',
            ),
            choiceColumn: ModalChoiceWidget(
              cancelText: '아니요',
              submitText: '네',
              onCancel: () {
                context.pop();
              },
              onSubmit: () {
                if (isEnableToClick) {
                  setState(() {
                    isEnableToClick = false;
                  });
                  getDenyTestChoiceMutation(onSuccess: (res, arg) {
                    context.go('/mails/assignment-start');
                  }, onError: (arg, error, fallback) {
                    setState(() {
                      isEnableToClick = true;
                    });
                    scaffoldMessengerKey.currentState?.showSnackBar(
                      const SnackBar(
                        content: Text(
                          '서버에 문제가 발생했습니다. 잠시 후 다시 시도해주세요.',
                        ),
                      ),
                    );
                  }).mutate(widget.testId);
                }
              },
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
            widget.onActiveScreen(ActiveScreen.detail);
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
            '${widget.characterFirstName}이가 마음에 드세요?\n${mailService.getNextMailReceiveTimeStr()}에\n첫 '
            '편지가 올 거에요 :)',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OutlinedButton(
                  onPressed: () {
                    showDenyModal();
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
                mutation: getConfirmTestMutation(
                  onSuccess: (res, arg) async {
                    await characterService
                        .saveSelectedCharacterId(widget.selectedCharacterId);
                    if (!mounted) return;
                    context.go('/');
                  },
                  onError: (arg, error, fallback) {
                    setState(() {
                      isEnableToClick = true;
                    });
                    scaffoldMessengerKey.currentState?.showSnackBar(
                      const SnackBar(
                        content: Text(
                          '서버에 문제가 발생했습니다. 잠시 후 다시 시도해주세요.',
                        ),
                      ),
                    );
                  },
                ),
                builder: (context, state, mutate) => FilledButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      isEnableToClick
                          ? Color(ref
                              .watch(characterThemeProvider)
                              .colors!
                              .primary!)
                          : Color(ref
                              .watch(characterThemeProvider)
                              .colors!
                              .secondary!),
                    ),
                  ),
                  onPressed: () {
                    if (isEnableToClick) {
                      setState(() {
                        isEnableToClick = false;
                      });
                      mutate(widget.testId);
                    }
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
