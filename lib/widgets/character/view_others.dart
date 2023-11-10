import 'dart:ui';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/dotted_underline.dart';

class ViewOthersWidget extends StatelessWidget {
  final num excludeId;

  const ViewOthersWidget({super.key, required this.excludeId});

  Widget addBlur(bool isBlurred) {
    if (isBlurred == false) {
      return const SizedBox.shrink();
    }
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = getAllCharactersQuery();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const DottedUnderline(0),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Text(
            '다른 상대도 살펴볼까요?',
            style: TextStyle(
              color: ColorConstants.neutral,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
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
                // crossAxisSpacing: -2.0,
                shrinkWrap: true,
                crossAxisCount: 3,
                children: filteredCharacters.map((character) {
                  if (character.is_active == false) {
                    return ClipRRect(
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  character.default_image,
                                  color: Colors.black45,
                                  colorBlendMode: BlendMode.darken,
                                ),
                              ),
                            ),
                            addBlur(true),
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
                        ),
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        num id = character.id;
                        context.push('/other-character/$id');
                      },
                      child: ClipRRect(
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(character.default_image),
                                ),
                              ),
                              addBlur(character.is_blurred!),
                            ],
                          ),
                        ),
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
