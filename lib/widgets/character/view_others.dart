import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';

class ViewOthersWidget extends StatelessWidget {
  final num excludeId;

  const ViewOthersWidget({super.key, required this.excludeId});

  @override
  Widget build(BuildContext context) {
    final query = getAllCharactersQuery();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 36.0),
          child: Text(
            '다른 상대도\n살펴볼까요?',
            style: TextStyle(
              color: ColorConstants.lightPink,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        QueryBuilder<List<Character>>(
          query: query,
          builder: (context, state) {
            if (state.data != null) {
              var filteredCharacters = state.data!
                  .where((character) => character.id != excludeId)
                  .toList();
              return GridView.count(
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                shrinkWrap: true,
                crossAxisCount: 3,
                children: filteredCharacters.map((character) {
                  if (character.is_active == false) {
                    return Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              character.default_image,
                              color: Colors.black45,
                              colorBlendMode: BlendMode.darken,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "공개\n예정",
                            style: TextStyle(
                              color: ColorConstants.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        num id = character.id;
                        context.push('/other-character/$id');
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(character.default_image),
                      ),
                    );
                  }
                }).toList(),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        const SizedBox(
          height: 36,
        ),
      ],
    );
  }
}
