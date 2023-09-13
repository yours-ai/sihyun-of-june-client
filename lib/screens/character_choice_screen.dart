import 'dart:ui';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';

import '../widgets/profile_widget.dart';

class CharacterChoiceScreen extends StatefulWidget {
  const CharacterChoiceScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CharacterChoiceScreen();
  }
}

class _CharacterChoiceScreen extends State<CharacterChoiceScreen> {
  @override
  Widget build(context) {
    return QueryBuilder(
      query: getPendingTestQuery(),
      builder: (context, state) {
        if (state.status == 'loading') {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        ;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorConstants.background,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Container(
                padding: const EdgeInsets.only(left: 23),
                child: Icon(
                  PhosphorIcons.arrow_left,
                  color: ColorConstants.black,
                  size: 32,
                ),
              ),
            ),
          ),
          body: state.data != null
              ? SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 28.0),
                          children: [
                            ProfileWidget(
                                Name: state.data!['character']['name'],
                                Age: (state.data!['character']['age']),
                                MBTI: state.data!['character']['MBTI'],
                                Description: state.data!['character']
                                    ['description'],
                                ImagePath: state.data!['character']['image']),
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
                                      return GridView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: state.data?.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 8,
                                          crossAxisSpacing: 8,
                                          childAspectRatio: 1.0,
                                        ),
                                        itemBuilder: (context, index) {
                                          final character = state.data![index];
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
                                                    .go('/othercharacter/$id');
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
                                    } else if (state.status == 'loading') {
                                      return Text('로딩중');
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                                SizedBox(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            OutlinedButton(
                                onPressed: () {
                                  context.go('/select');
                                },
                                child: Text('친구에게 자랑하기')),
                            SizedBox(
                              height: 10,
                            ),
                            FilledButton(
                                onPressed: () {
                                  context.go('/select');
                                },
                                child: Text('다음')),
                          ],
                        ),
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
