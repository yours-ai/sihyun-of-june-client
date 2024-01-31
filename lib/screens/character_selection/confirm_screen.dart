import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/globals.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';

class CharacterSelectionConfirmScreen extends StatefulWidget {
  final int characterId, primaryColor, secondaryColor;
  final String firstName;

  const CharacterSelectionConfirmScreen({
    super.key,
    required this.characterId,
    required this.primaryColor,
    required this.secondaryColor,
    required this.firstName,
  });

  @override
  State<CharacterSelectionConfirmScreen> createState() =>
      _CharacterSelectionConfirmScreenState();
}

class _CharacterSelectionConfirmScreenState
    extends State<CharacterSelectionConfirmScreen> {
  bool isEnableToClick = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TitleLayout(
          body: Text(
            '${widget.firstName}이가 마음에 드세요?\n${mailService.getNextMailReceiveTimeStr()}에\n첫 편지가 올 거에요 :)',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OutlinedButton(
                  onPressed: () {
                    context.pop();
                    context.pop();
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
              QueryBuilder(
                  query: getSelectionStatusQuery(),
                  builder: (context, selectionState) {
                    if (selectionState.data == null) {
                      return const SizedBox.shrink();
                    }
                    return MutationBuilder(
                      mutation: getConfirmSelectionMutation(
                        characterId: widget.characterId,
                        selectionId: selectionState.data!['id'],
                        onSuccess: (res, arg) async {
                          await characterService
                              .saveSelectedCharacterId(widget.characterId);
                          if (!mounted) return;
                          context.go(RoutePaths.starting);
                        },
                        onError: (res, arg, error) {
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
                          context.go(RoutePaths.starting);
                        },
                      ),
                      builder: (context, mutationState, mutate) => FilledButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            mutationState.status != QueryStatus.loading
                                ? Color(widget.primaryColor)
                                : Color(widget.secondaryColor),
                          ),
                        ),
                        onPressed: () {
                          if (isEnableToClick) {
                            setState(() {
                              isEnableToClick = false;
                            });
                            mutate(null);
                          }
                        },
                        child: const Text(
                          '네',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
