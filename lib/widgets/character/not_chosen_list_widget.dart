import 'package:extended_image/extended_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/services/unique_cachekey_service.dart';

class NotChosenListWidget extends ConsumerWidget {
  final bool isEnableToRetest;
  final List<Character> filteredCharacters;

  const NotChosenListWidget({
    super.key,
    required this.isEnableToRetest,
    required this.filteredCharacters,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                      .getMainImage(character.character_info.images);
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
                                  cacheMaxAge: CachingDuration.image,
                                  cacheKey: UniqueCacheKeyService.makeUniqueKey(
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
  }
}
