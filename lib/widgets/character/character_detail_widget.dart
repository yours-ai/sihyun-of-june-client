import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/profile_widget.dart';

import '../../screens/character_choice_screen.dart';

class CharacterDetailWidget extends StatelessWidget {
  final void Function(ActiveScreen) onActiveScreen;
  final void Function(int) onTestId;
  final void Function(String) onName;

  const CharacterDetailWidget(
      {super.key,
      required this.onActiveScreen,
      required this.onTestId,
      required this.onName});

  @override
  Widget build(BuildContext context) {
    final query = getPendingTestQuery();
    return QueryBuilder(
      query: query,
      builder: (context, state) {
        int excludeId = state.data?['character']['id'] ?? 0;
        if (state.status == 'loading') {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        ;
        return Scaffold(
          body: state.data != null
              ? SafeArea(
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
                                age: (state.data!['character']['age']),
                                mbti: state.data!['character']['MBTI'],
                                description: state.data!['character']
                                    ['description'],
                                imageSrc: state.data!['character']['image']),
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
                              onName(state.data!['character']['name']
                                  .substring(1));
                            },
                            child: const Text('다음')),
                      ),
                    ],
                  ),
                )
              : Container(),
        );
      },
    );
  }
}
