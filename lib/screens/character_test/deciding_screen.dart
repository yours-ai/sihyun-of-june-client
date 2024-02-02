import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/widgets/character/profile_list_widget.dart';

class TestDecidingScreen extends ConsumerWidget {
  const TestDecidingScreen({super.key});

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
            query: getCharacterQuery(id: testState.data!['character_id']),
            builder: (context, selectedCharacterState) {
              if (selectedCharacterState.status != QueryStatus.success ||
                  selectedCharacterState.data == null) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return ProfileListWidget(
                profileWidgetType: ProfileWidgetType.test,
                characterList: [selectedCharacterState.data!],
                testId: testState.data!['test_id'],
              );
            });
      },
    );
  }
}
