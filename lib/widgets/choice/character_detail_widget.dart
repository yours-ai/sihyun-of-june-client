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
    return QueryBuilder(
      query: getPendingTestQuery(),
      builder: (context, state) {
        int excludeId = state.data?['character']['id'] ?? 0;
        if (state.status == 'loading') {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        };
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
                          padding: const EdgeInsets.symmetric(horizontal: 28.0),
                          children: [
                            ProfileWidget(
                                name: state.data!['character']['name'],
                                age: (state.data!['character']['age']),
                                mbti: state.data!['character']['MBTI'],
                                description: state.data!['character']
                                    ['description'],
                                imageSrc: state.data!['character']['image']),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 36.0),
                                  child: Text(
                                    '다른 상대도\n살펴볼까요?',
                                    style: TextStyle(
                                      color: ColorConstants.secondary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                QueryBuilder<List<Character>>(
                                  query: getAllCharactersQuery(),
                                  builder: (context, state) {
                                    if (state.data != null) {
                                      var filteredCharacters = state.data!
                                          .where((character) =>
                                              character.id != excludeId)
                                          .toList();
                                      return GridView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: filteredCharacters.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 8,
                                          crossAxisSpacing: 8,
                                          childAspectRatio: 1.0,
                                        ),
                                        itemBuilder: (context, index) {
                                          final character = filteredCharacters[index];
                                          if (character.is_active == false) {
                                            return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.network(
                                                  character.image),
                                            );
                                          } else {
                                            return GestureDetector(
                                              onTap: () {
                                                num id = character.id;
                                                context
                                                    .go('/other-character/$id');
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.network(
                                                    character.image),
                                              ),
                                            );
                                          }
                                        },
                                      );
                                    } else if ('loading' == state.status) {
                                      return const Text('로딩중');
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 36,
                                ),
                              ],
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
