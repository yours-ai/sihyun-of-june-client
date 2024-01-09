import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/actions/notification/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/common/back_appbar.dart';
import 'package:project_june_client/widgets/character/profile_widget.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';

class CharacterSelectionDecidedConfirmScreen extends StatelessWidget {
  final int id, primaryColor, secondaryColor;
  final String firstName;

  const CharacterSelectionDecidedConfirmScreen({
    super.key,
    required this.id,
    required this.primaryColor,
    required this.secondaryColor,
    required this.firstName,
  });

  @override
  Widget build(BuildContext context) {
    final query = getCharacterQuery(id: id);
    return QueryBuilder(
      query: query,
      builder: (context, state) {
        if (state.data == null) {
          return const SizedBox.shrink();
        }
        return Scaffold(
          appBar: const BackAppbar(),
          body: SafeArea(
            child: TitleLayout(
              withAppBar: true,
              title: Text(
                '$firstName이가 마음에 드세요?\n${mailService.getNextMailReceiveTimeStr()}에\n첫 편지가 올 거에요 :)',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              actions: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        context.go('/character-selection-deciding');
                      },
                      child: Text(
                        '다른 상대로 할게요.',
                        style: TextStyle(
                          color: ColorConstants.gray,
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  MutationBuilder(
                    mutation: readAllNotificationMutation(
                      //TODO: select confirm mutation으로 바꿔야 함
                      onSuccess: (res, arg) {
                        // characterService
                        //     .saveSelectedCharacterId(selectedCharacterId);
                        context.go('/');
                      },
                    ),
                    builder: (context, state, mutate) => FilledButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          state.status != QueryStatus.loading
                              ? Color(primaryColor)
                              : Color(secondaryColor),
                        ),
                      ),
                      onPressed: () {
                        if (state.status == QueryStatus.loading) return;
                        // mutate(testId); //TODO: testId를 이전, 이전전 스크린부터 props로 받아야 함
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
      },
    );
  }
}
