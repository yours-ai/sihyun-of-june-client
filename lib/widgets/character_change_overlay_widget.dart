import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/providers/mail_list_provider.dart';
import 'package:project_june_client/widgets/retest/retest_modal_widget.dart';

import '../actions/character/models/Character.dart';
import '../constants.dart';
import '../providers/character_provider.dart';
import '../providers/common_provider.dart';
import '../services.dart';
import '../services/unique_cachekey_service.dart';

class CharacterChangeOverlayWidget extends ConsumerWidget {
  final Character? character;
  final VoidCallback? hideOverlay;
  final List<int>? characterIds;
  final String? firstName;

  const CharacterChangeOverlayWidget({
    this.character,
    this.hideOverlay,
    this.characterIds,
    this.firstName,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int characterId = ref.watch(selectedCharacterProvider)!;
    final bool isSelected = characterId == character?.id;
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: () async {
        if (isSelected) return;

        if (character == null) {
          final bool is30DaysFinished = await getRetrieveMeQuery()
              .result
              .then((value) => value.data!.is_30days_finished);
          if (is30DaysFinished == false) {
            showModalBottomSheet(
              context: context,
              builder: (context) => RetestModalWidget(
                firstName: firstName,
              ),
            );
            hideOverlay!();
            return;
          }
          context.push(
            '/retest',
            extra: {
              'characterIds': characterIds,
              'firstName': firstName,
            },
          );
          return;
        }
        if (ref.watch(initializeMailListProvider) != null) {
          ref.watch(initializeMailListProvider);
        }
        characterService.changeCharacterByTap(ref, character!);
        hideOverlay!();
      }, // 캐릭터 전환 or 추가 배정받기
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? ColorConstants.background
              : ColorConstants.veryLightGray,
          border: Border(
            top: BorderSide(
              width: 1,
              color: ColorConstants.veryLightGray,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(right: character == null ? 0 : 5),
              child: Text(
                character == null
                    ? '새 친구 만나기'
                    : 'D+${mailService.getMailDateDiff(DateTime.now(), character!.date_allocated!.first) + 1} ${character?.name}',
                style: TextStyle(
                  color: isSelected
                      ? Color(
                          ref.watch(characterThemeProvider).colors!.primary!)
                      : ColorConstants.neutral,
                  fontSize: 20,
                  height: 1,
                  letterSpacing: 1.5,
                  fontWeight: FontWeightConstants.semiBold,
                  fontFamily: 'NanumJungHagSaeng',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  child: character == null
                      ? Icon(
                          PhosphorIcons.plus_circle_thin,
                          size: 45,
                          color: ColorConstants.neutral,
                        )
                      : ExtendedImage.network(
                          timeLimit: ref.watch(imageCacheDurationProvider),
                          cacheKey: UniqueCacheKeyService.makeUniqueKey(
                              characterService
                                  .getMainImage(
                                      character!.character_info!.images!)
                                  .src),
                          characterService
                              .getMainImage(character!.character_info!.images!)
                              .src,
                          fit: BoxFit.cover,
                          width: 40,
                          height: 40,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
