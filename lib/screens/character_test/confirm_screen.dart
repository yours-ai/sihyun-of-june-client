import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/models/CharacterTheme.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import '../../constants.dart';
import '../../globals.dart';
import '../../services.dart';

class CharacterTestConfirmScreen extends ConsumerStatefulWidget {
  final int testId;
  final int selectedCharacterId;
  final String selectedCharacterFirstName;
  final CharacterTheme selectedCharacterTheme;

  const CharacterTestConfirmScreen({
    super.key,
    required this.selectedCharacterId,
    required this.testId,
    required this.selectedCharacterFirstName,
    required this.selectedCharacterTheme,
  });

  @override
  TestConfirmScreenState createState() {
    return TestConfirmScreenState();
  }
}

class TestConfirmScreenState extends ConsumerState<CharacterTestConfirmScreen> {
  bool isEnableToClick = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TitleLayout(
          body: Text(
            '${widget.selectedCharacterFirstName}이가 마음에 드세요?\n${mailService.getNextMailReceiveTimeStr()}에\n첫 '
            '편지가 올 거에요 :)',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: MutationBuilder(mutation: confirmTestMutation(
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
          ), builder: (context, state, mutate) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OutlinedButton(
                    onPressed: () async {
                      if (isEnableToClick) {
                        setState(() {
                          isEnableToClick = false;
                        });
                        await mutate(widget.testId).then((_) async {
                          ref.read(characterThemeProvider.notifier).state =
                              widget.selectedCharacterTheme;
                          ref.read(selectedCharacterProvider.notifier).state =
                              widget.selectedCharacterId;
                          await characterService.saveSelectedCharacterId(
                              widget.selectedCharacterId);
                          if (!mounted) return;
                          context.go(RoutePaths.homeDecideAssignmentMethod);
                        });
                      }
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
                FilledButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      isEnableToClick
                          ? Color(widget.selectedCharacterTheme.colors.primary)
                          : Color(
                              widget.selectedCharacterTheme.colors.secondary),
                    ),
                  ),
                  onPressed: () async {
                    if (isEnableToClick) {
                      setState(() {
                        isEnableToClick = false;
                      });
                      await mutate(widget.testId).then((_) async {
                        ref.read(characterThemeProvider.notifier).state =
                            widget.selectedCharacterTheme;
                        ref.read(selectedCharacterProvider.notifier).state =
                            widget.selectedCharacterId;
                        await characterService.saveSelectedCharacterId(
                            widget.selectedCharacterId);
                        if (!mounted) return;
                        context.go(RoutePaths.starting);
                      });
                    }
                  },
                  child: const Text(
                    '네',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
