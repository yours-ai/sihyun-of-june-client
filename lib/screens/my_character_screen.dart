import 'dart:ui';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/constants.dart';

import '../actions/character/models/Character.dart';
import '../actions/character/queries.dart';

class MyCharacterScreen extends StatelessWidget {
  const MyCharacterScreen({super.key});

  @override
  Widget build(context) {
    return QueryBuilder(
        query: getRetrieveMyCharacterQuery(),
        builder: (context, state) {
          int excludeId = state.data?[0].id ?? 0;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: ColorConstants.background,
              elevation: 0,
              leading: IconButton(
                onPressed: () => context.pop(),
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
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      state.data![0].image,
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 36.0),
                      child: Text(
                        '${state.data![0].name}, ${state.data![0].age}\n${state.data![0].MBTI}',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )),
                  Text(
                    state.data![0].name ?? '',
                    style:
                        TextStyle(fontSize: 18, color: ColorConstants.neutral),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 36.0),
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
                            .where((character) => character.id != excludeId)
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
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(character.image),
                              );
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  num id = character.id;
                                  context.push('/other-character/$id');
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(character.image),
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
            ),
          );
        });
  }
}
