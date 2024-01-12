import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/providers/user_provider.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/character/not_chosen_list_widget.dart';
import 'package:project_june_client/widgets/common/back_appbar.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';

class AssignmentStartScreen extends ConsumerWidget {
  const AssignmentStartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isEnableToRetest = ref.watch(isEnableToRetestProvider);
    return Scaffold(
      appBar: const BackAppbar(),
      body: SafeArea(
        child: QueryBuilder(
            query: getRetrieveMeQuery(),
            builder: (context, myInfoState) {
              if (myInfoState.data == null) {
                return const SizedBox.shrink();
              }
              return TitleLayout(
                title: Text(
                  '${myInfoState.data!.first_name}님과 편지를\n나눌 상대를 정해드릴게요.',
                  style: Theme.of(context).textTheme.titleLarge,
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
                body: QueryBuilder(
                    query: getRetrieveMyCharacterQuery(),
                    builder: (context, myCharacterState) {
                      if (myCharacterState.data == null) {
                        return const SizedBox.shrink();
                      }
                      return QueryBuilder(
                        query: getAllCharactersQuery(),
                        builder: (context, allCharacterState) {
                          if (allCharacterState.data == null) {
                            return const SizedBox.shrink();
                          }
                          final characterIds = characterService
                              .getCharacterIds(myCharacterState.data!);
                          final filteredCharacters = isEnableToRetest
                              ? allCharacterState.data!
                                  .where((character) =>
                                      !characterIds.contains(character.id))
                                  .toList()
                              : allCharacterState.data!;
                          return NotChosenListWidget(
                            isEnableToRetest: isEnableToRetest,
                            filteredCharacters: filteredCharacters,
                          );
                          return const SizedBox.shrink();
                        },
                      );
                    }),
                actions: FilledButton(
                  style: Theme.of(context).filledButtonTheme.style!.copyWith(
                        backgroundColor:
                            MaterialStateProperty.all(ColorConstants.pink),
                      ),
                  onPressed: () {
                    context.pushNamed('assignment-decide');
                  },
                  child: const Text('다음'),
                ),
              );
            }),
      ),
    );
  }
}
