import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/services/unique_cachekey_service.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';

import '../../providers/common_provider.dart';

class CharacterSelectionDecidingScreen extends ConsumerWidget {
  const CharacterSelectionDecidingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.background,
        elevation: 0,
        title: QueryBuilder(
          query: getSelectionStatusQuery(),
          builder: (context, state) {
            if (state.status == QueryStatus.success &&
                state.data!['reason'] == 'NEW_USER') {
              return Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Center(
                  child: Text(
                    '편지를 받을 준비가 거의 끝났어요!',
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorConstants.neutral,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeightConstants.semiBold,
                    ),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      body: SafeArea(
        child: TitleLayout(
          withAppBar: true,
          title: Text(
            '어떤 상대와\n편지를 나누고 싶으세요?',
            style: Theme.of(context).textTheme.titleLarge,
            softWrap: true,
            textAlign: TextAlign.center,
          ),
          body: QueryBuilder(
              query: getRetrieveMyCharacterQuery(),
              builder: (context, myCharacterState) {
                if (myCharacterState.data == null) {
                  return const SizedBox.shrink();
                }
                return QueryBuilder(
                  query: getAllCharactersQuery(),
                  builder: (context, allCharacterState) {
                    if (allCharacterState.data == null) {
                      return const SizedBox.shrink();
                    }
                    final characterIds = characterService
                        .getCharacterIds(myCharacterState.data!);
                    final filteredCharacters = allCharacterState.data!
                        .where(
                            (character) => !characterIds.contains(character.id))
                        .toList();

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.0,
                        vertical: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GridView.count(
                              mainAxisSpacing: 16,
                              shrinkWrap: true,
                              crossAxisCount: 3,
                              children: filteredCharacters.map(
                                (character) {
                                  final mainImageSrc =
                                      characterService.getMainImage(
                                          character.character_info.images);
                                  return GestureDetector(
                                    onTap: () {
                                      if (!character.is_active) {
                                        return;
                                      }
                                      num id = character.id;
                                      context.pushNamed(RouteNames.character,
                                          pathParameters: {
                                            'id': id.toString()
                                          });
                                    },
                                    child: ClipRRect(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Stack(
                                          children: [
                                            Positioned.fill(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: ExtendedImage.network(
                                                  mainImageSrc.src,
                                                  cacheMaxAge:
                                                      CachingDuration.image,
                                                  cacheKey:
                                                      UniqueCacheKeyService
                                                          .makeUniqueKey(
                                                              mainImageSrc.src),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).toList()),
                        ],
                      ),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
