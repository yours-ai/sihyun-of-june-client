import 'dart:ui';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/providers/common_provider.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/services/unique_cachekey_service.dart';
import 'package:project_june_client/widgets/common/dotted_underline.dart';

class ViewOthersWidget extends ConsumerWidget {
  final num excludeId;

  const ViewOthersWidget({super.key, required this.excludeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              fontWeight: FontWeightConstants.semiBold,
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
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: filteredCharacters.map(
                    (character) {
                      final mainImageSrc = characterService
                          .getMainImage(character.character_info!.images!);
                      return GestureDetector(
                        onTap: () {
                          if (!character.is_active) {
                            return;
                          }
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
                                    child: ExtendedImage.network(
                                      mainImageSrc.src,
                                      timeLimit:
                                          ref.watch(imageCacheDurationProvider),
                                      cacheKey:
                                          UniqueCacheKeyService.makeUniqueKey(
                                              mainImageSrc.src),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                if (!character.is_active) ...[
                                  ...characterService.addBlur(),
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
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList());
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
