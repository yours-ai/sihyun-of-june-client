import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/widgets/character/profile_widget.dart';

import '../../screens/character_test/character_choice_screen.dart';

class CharacterDetailWidget extends ConsumerWidget {
  final void Function(ActiveScreen) onActiveScreen;
  final void Function(TestReason, int, String, int) onTestInfo;

  const CharacterDetailWidget(
      {super.key, required this.onActiveScreen, required this.onTestInfo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = getPendingTestQuery();
    return QueryBuilder(
      query: query,
      builder: (context, state) {
        Character? character;
        if (state.data == null) {
          return const SizedBox.shrink();
        }
        String testReason = state.data!['test_reason'];
        character = Character.fromJson(state.data!['character']);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(characterThemeProvider.notifier).state = character!.theme!;
        });
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28.0,
                      vertical: 10,
                    ),
                    children: [
                      ProfileWidget(
                        name: character.name!,
                        characterInfo: character.character_info!,
                        primaryColor: Color(character.theme!.colors!.primary!),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 28.0, right: 28.0, bottom: 20.0),
                  child: FilledButton(
                    onPressed: () {
                      onTestInfo(
                          testReason == 'NEW_USER'
                              ? TestReason.newUser
                              : TestReason.retest,
                          state.data!['test_id'],
                          character!.first_name!,
                          character.id!);
                    },
                    child: const Text('다음'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
