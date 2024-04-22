import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/widgets/common/modal/modal_description_widget.dart';
import 'package:project_june_client/widgets/common/modal/modal_widget.dart';

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
            query: fetchMeQuery(),
            builder: (context, state) {
              if (state.data == null) {
                return const SizedBox.shrink();
              }
              return GestureDetector(
                onTap: () async {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ModalWidget(
                        title: '서비스 종료 예정으로\n더 이상 새로운 친구를 만나볼 수 없어요.',
                        choiceColumn: FilledButton(
                          onPressed: () => context.pop(),
                          child: const Text('알겠어요'),
                        ),
                      );
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
