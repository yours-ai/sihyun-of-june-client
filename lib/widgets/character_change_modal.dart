import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/retest/retest_modal_widget.dart';

import '../actions/auth/queries.dart';
import '../actions/character/models/Character.dart';
import '../constants.dart';
import '../providers/character_provider.dart';
import 'character_change_list_widget.dart';

class CharacterChangeModal extends ConsumerWidget {
  final List<Character> characterList;

  const CharacterChangeModal({super.key, required this.characterList});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: ColorConstants.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...characterList
              .where((character) =>
                  ref.watch(selectedCharacterProvider) == character.id)
              .map((character) => CharacterChangeListWidget(
                  character: character,
                  isSelected:
                      ref.watch(selectedCharacterProvider) == character.id))
              .toList(),
          ...characterList
              .where((character) =>
                  ref.watch(selectedCharacterProvider) != character.id)
              .map((character) => CharacterChangeListWidget(
                  character: character,
                  isSelected:
                      ref.watch(selectedCharacterProvider) == character.id))
              .toList(),
          QueryBuilder(
            query: getRetrieveMeQuery(),
            builder: (context, state) {
              if (state.data == null) {
                return const SizedBox.shrink();
              }
              return GestureDetector(
                onTap: () async {
                  if (characterList.isEmpty) {
                    context.go('/assignment');
                    return;
                  }
                  final firstName = characterService
                      .getCurrentCharacterFirstName(characterList);
                  if (firstName == '') {
                    context.go('/assignment');
                    return;
                  }
                  if (state.data!.is_30days_finished == false) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => RetestModalWidget(
                          firstName: characterService
                              .getCurrentCharacterFirstName(characterList)),
                    );
                    return;
                  }
                  context.push(
                    '/retest',
                    extra: {
                      'characterIds':
                          characterService.getCharacterIds(characterList),
                      'firstName': firstName,
                    },
                  );
                },
                child: Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 13.5,
                          vertical: 8.0,
                        ),
                        child: Icon(
                          PhosphorIcons.plus_circle_fill,
                          color: ColorConstants.primary,
                          size: 45,
                        )),
                    Expanded(
                      child: Text(
                        '새 친구 만나기',
                        style: TextStyle(
                          fontSize: 17,
                          color: ColorConstants.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
