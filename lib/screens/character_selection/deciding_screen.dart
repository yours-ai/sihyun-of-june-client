import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/character/profile_list_widget.dart';

class CharacterSelectionDecidingScreen extends ConsumerWidget {
  const CharacterSelectionDecidingScreen({super.key});

  List<Character> _sortCharacterList({
    required List<Character> allCharacterList,
    required List<Character> myCharacterList,
  }) {
    final myCharacterIdList = characterService.getCharacterIds(myCharacterList);
    final notMyCharacterList = allCharacterList
        .where((character) => !myCharacterIdList.contains(character.id))
        .toList();
    return notMyCharacterList;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return QueryBuilder(
        query: getAllCharactersQuery(),
        builder: (context, allCharacterState) {
          if (allCharacterState.status != QueryStatus.success ||
              allCharacterState.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          getRetrieveMyCharacterQuery().refetch();
          return QueryBuilder(
            query: getRetrieveMyCharacterQuery(),
            builder: (context, myCharacterState) {
              if (myCharacterState.status != QueryStatus.success ||
                  myCharacterState.data == null) {
                return const Center(child: CircularProgressIndicator());
              }
              final sortedCharacterList = _sortCharacterList(
                allCharacterList: allCharacterState.data!,
                myCharacterList: myCharacterState.data!,
              );
              return ProfileListWidget(
                profileWidgetType: ProfileWidgetType.selection,
                characterList: sortedCharacterList,
              );
            },
          );
        });
  }
}
