import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/character/models/character.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/character/profile_list_widget.dart';

class MyCharacterScreen extends ConsumerWidget {
  const MyCharacterScreen({super.key});

  List<Character> _sortCharacterList({
    required List<Character> allCharacterList,
    required List<Character> myCharacterList,
    required int selectedCharacterId,
  }) {
    var selectedMyCharacterList = <Character>[];
    var notSelectedMyCharacterList = <Character>[];
    for (final myCharacter in myCharacterList) {
      if (myCharacter.id == selectedCharacterId) {
        selectedMyCharacterList.add(myCharacter);
      } else {
        notSelectedMyCharacterList.add(myCharacter);
      }
    }
    final myCharacterIdList = characterService.getCharacterIds(myCharacterList);
    final notMyCharacterList = allCharacterList
        .where((character) => !myCharacterIdList.contains(character.id))
        .toList();
    return [
      ...selectedMyCharacterList,
      ...notSelectedMyCharacterList,
      ...notMyCharacterList,
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return QueryBuilder(
      query: fetchAllCharactersQuery(),
      builder: (context, allCharacterState) {
        if (allCharacterState.status != QueryStatus.success ||
            allCharacterState.data == null) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        return QueryBuilder(
          query: fetchMyCharactersQuery(),
          builder: (context, myCharacterState) {
            final selectedCharacterId = ref.watch(selectedCharacterProvider)?.id;
            if (myCharacterState.status != QueryStatus.success ||
                myCharacterState.data == null ||
                selectedCharacterId == null) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            final sortedCharacterList = _sortCharacterList(
              allCharacterList: allCharacterState.data!,
              myCharacterList: myCharacterState.data!,
              selectedCharacterId: selectedCharacterId,
            );
            return ProfileListWidget(
              profileWidgetType: ProfileWidgetType.myCharacterProfile,
              characterList: sortedCharacterList,
              parentRef: ref,
            );
          },
        );
      },
    );
  }
}
