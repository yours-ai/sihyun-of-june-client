import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/widgets/retest/retest_layout_widget.dart';

import '../../actions/character/models/Character.dart';
import '../../actions/character/queries.dart';
import '../../constants.dart';
import '../../providers/common_provider.dart';
import '../../providers/user_provider.dart';
import '../../services.dart';
import '../../services/unique_cachekey_service.dart';

class RetestInfoScreen extends ConsumerWidget {
  final String firstName;
  final List<int> characterIds;

  const RetestInfoScreen({
    super.key,
    required this.firstName,
    required this.characterIds,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isEnableToRetest = ref.watch(isEnableToRetestProvider);
    return RetestLayoutWidget(
      firstName: firstName,
      title:
          '$firstName이와의 시간, 즐거우셨나요?\n${isEnableToRetest ? '이제, 새로운 상대를\n만날 수 있어요.' : '조금 더 이어갈 수 있어요.'}',
      body: QueryBuilder<List<Character>>(
        query: getAllCharactersQuery(),
        builder: (context, state) {
          if (state.data != null) {
            var filteredCharacters = isEnableToRetest
                ? state.data!
                    .where((character) => !characterIds.contains(character.id))
                    .toList()
                : state.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isEnableToRetest ? '아직 만나보지 않은 상대들이에요.' : '모든 상대를 만나 보셨군요!',
                    style: TextStyle(
                      color: ColorConstants.mediumGray,
                      fontWeight: FontWeightConstants.semiBold,
                    ),
                  ),
                  GridView.count(
                      mainAxisSpacing: 16,
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
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: ExtendedImage.network(
                                          mainImageSrc.src,
                                          timeLimit: ref.watch(
                                              imageCacheDurationProvider),
                                          cacheKey: UniqueCacheKeyService
                                              .makeUniqueKey(mainImageSrc.src),
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
                      ).toList()),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      action: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FilledButton(
            style: Theme.of(context).filledButtonTheme.style!.copyWith(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(ColorConstants.gray),
                ),
            onPressed: () {
              context.push(
                '/retest/extend',
                extra: firstName,
              );
            },
            child: Text('$firstName이와의 시간 이어가기'),
          ),
          const SizedBox(
            height: 13,
          ),
          FilledButton(
            style: isEnableToRetest
                ? null
                : Theme.of(context).filledButtonTheme.style!.copyWith(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ColorConstants.veryLightGray),
                    ),
            onPressed: () {
              if (!isEnableToRetest) {
                return;
              }
              context.push(
                '/retest/confirm',
                extra: firstName,
              );
            },
            child: Text(
              '새로운 상대 만나기',
              style: TextStyle(
                  color: ColorConstants.background
                      .withOpacity(isEnableToRetest ? 1.0 : 0.7)),
            ),
          ),
        ],
      ),
    );
  }
}
