import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/widgets/character/profile_list_widget.dart';

class TestDecidingScreen extends ConsumerWidget {
  const TestDecidingScreen({super.key});

  List<Character> _sortCharacterList({
    required List<Character> allCharacterList,
    required int selectedCharacterId,
  }) {
    final selectedCharacterList = allCharacterList
        .where((character) => character.id == selectedCharacterId)
        .toList();
    final notMyCharacterList = allCharacterList
        .where((character) => character.id != selectedCharacterId)
        .toList();
    return [
      ...selectedCharacterList,
      ...notMyCharacterList,
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return QueryBuilder(
      query: getPendingTestQuery(),
      builder: (context, testState) {
        if (testState.status != QueryStatus.success || testState.data == null) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        return QueryBuilder(
            query: getAllCharactersQuery(),
            builder: (context, allCharacterState) {
              if (allCharacterState.status != QueryStatus.success ||
                  allCharacterState.data == null) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              final sortedCharacterList = _sortCharacterList(
                allCharacterList: allCharacterState.data!,
                selectedCharacterId: testState.data!['character_id'],
              );
              return ProfileListWidget(
                profileWidgetType: ProfileWidgetType.test,
                characterList: sortedCharacterList,
                testId: testState.data!['test_id'],
              );
            });
      },
    );
  }
}
