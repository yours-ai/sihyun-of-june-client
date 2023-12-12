import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../actions/character/models/Character.dart';
import '../constants.dart';
import '../providers/character_provider.dart';
import '../providers/common_provider.dart';
import '../services.dart';
import '../services/unique_cachekey_service.dart';

class CharacterChangeOverlayWidget extends ConsumerWidget {
  final Character? character;

  CharacterChangeOverlayWidget({this.character, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int characterId = 3; //TODO : provider 로 변경
    return Container(
      decoration: BoxDecoration(
        color: characterId == character?.id
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text(
              character == null
                  ? '새 친구 만나기'
                  : 'D+${mailService.getMailDateDiff(DateTime.now(), DateTime.now()
                      //character.date_time TODO: character에서 내려줄 것임!
                      )} ${character?.name}',
              style: TextStyle(
                color: characterId == character?.id
                    ? Color(ref.watch(characterThemeProvider).colors!.primary!)
                    : ColorConstants.neutral,
                fontSize: 20,
                height: 1,
                letterSpacing: 2,
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
                width: 40,
                height: 40,
                child: character == null
                    ? Icon(
                        PhosphorIcons.plus_circle_thin,
                        size: 40,
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
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
