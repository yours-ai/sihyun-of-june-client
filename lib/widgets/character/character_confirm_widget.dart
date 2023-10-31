import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';

import '../../constants.dart';
import '../../screens/character_choice_screen.dart';
import '../../services.dart';
import '../modal_widget.dart';

class CharacterConfirmWidget extends StatelessWidget {
  final int testId;
  final String name;
  final void Function(ActiveScreen) onActiveScreen;

  const CharacterConfirmWidget(
      {super.key,
      required this.onActiveScreen,
      required this.testId,
      required this.name});

  @override
  Widget build(BuildContext context) {
    _showDenyModal() async {
      await showModalBottomSheet<void>(
        context: context,
        useRootNavigator: true,
        builder: (BuildContext context) {
          return ModalWidget(
            title: '정말 다른 상대로 정해드릴까요?',
            choiceColumn: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FilledButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      ColorConstants.background,
                    ),
                  ),
                  onPressed: () {
                    context.pop();
                  },
                  child: Text('됐어요',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: ColorConstants.lightPink,
                      )),
                ),
                SizedBox(
                  height: 12,
                ),
                MutationBuilder(
                  mutation: getDenyChoiceMutation(
                    onSuccess: (res, arg) {
                      context.pop();
                      context.go('/character-test');
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
              color: ColorConstants.black,
              size: 32,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: TitleLayout(
          withAppBar: true,
          titleText:
              '$name이가 마음에 드세요?\n${mailService.getNextMailReceiveTimeStr()}에\n첫 편지가 올 거에요.',
          actions: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OutlinedButton(
                  onPressed: () {
                    _showDenyModal();
                  },
                  child: const Text('다른 상대로 해주세요.')),
              const SizedBox(
                height: 10,
              ),
              MutationBuilder(
                mutation: getConfirmChoiceMutation(
                  onSuccess: (res, arg) {
                    context.go('/mails');
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
