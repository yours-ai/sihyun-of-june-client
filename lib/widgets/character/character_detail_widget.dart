import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/actions/character/models/CharacterTheme.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/main.dart';
import 'package:project_june_client/widgets/profile_widget.dart';

import '../../screens/character_choice_screen.dart';

class CharacterDetailWidget extends ConsumerWidget {
  final void Function(ActiveScreen) onActiveScreen;
  final void Function(int) onTestId;
  final void Function(String) onName;

  const CharacterDetailWidget(
      {super.key,
      required this.onActiveScreen,
      required this.onTestId,
      required this.onName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = getPendingTestQuery();
    return QueryBuilder(
      query: query,
      builder: (context, state) {
        if (state.data == null) {
          return const SizedBox.shrink();
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CharacterTheme characterTheme = state.data!['character']['theme'];
          ref.read(characterThemeProvider.notifier).state = characterTheme;
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
                        name: state.data!['character']['name'],
                        defaultImage: state.data!['character']['default_image'],
                        characterInfo: state.data!['character']
                            ['character_info'],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 28.0, right: 28.0, bottom: 20.0),
                  child: FilledButton(
                    onPressed: () {
                      onActiveScreen(ActiveScreen.confirm);
                      onTestId(state.data!['test_id']);
                      onName(state.data!['character']['name'].substring(1));
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
