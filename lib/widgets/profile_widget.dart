import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/character/models/CharacterInfo.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/main.dart';
import 'package:project_june_client/screens/profile_details_screen.dart';
import 'package:project_june_client/services/unique_cachekey_service.dart';

class ProfileWidget extends ConsumerWidget {
  final String? name;
  final CharacterInfo characterInfo;
  final Color primaryColor;
  final String defaultImage;

  const ProfileWidget({
    super.key,
    required this.name,
    required this.characterInfo,
    required this.primaryColor,
    required this.defaultImage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stackedImageList = characterInfo.images!.length > 3
        ? characterInfo.images!
            .sublist(characterInfo.images!.length - 3)
            .reversed
            .toList()
        : characterInfo.images!.reversed.toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          alignment: Alignment.center,
          children: List.generate(stackedImageList.length, (index) {
            // 각 이미지를 2도씩 회전시키기 위한 각도 계산
            final angle =
                3 * ((stackedImageList.length - 1) / 2 - index) * 3.14 / 360;
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) =>
                      ProfileDetailsScreen(characterInfo.images!),
                );
              },
              child: Transform.rotate(
                angle: angle,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: SizedBox(
                    width: 320,
                    height: 480,
                    child: ExtendedImage.network(
                      timeLimit: ref.watch(imageCacheDurationProvider),
                      cacheKey: UniqueCacheKeyService.makeUniqueKey(
                          stackedImageList[index]),
                      stackedImageList[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 36),
        Center(
          child: Text(
            '$name(${characterInfo.age})',
            style: TextStyle(
              color: primaryColor,
              fontFamily: 'NanumJungHagSaeng',
              fontSize: 54,
              fontWeight: FontWeightConstants.semiBold,
              letterSpacing: 2,
            ),
          ),
        ),
        Center(
          child: Text(
            '${characterInfo.one_line_description}',
            style: TextStyle(
              color: ColorConstants.primary,
              fontFamily: 'NanumJungHagSaeng',
              fontSize: 32,
              height: 28 / 32,
              fontWeight: FontWeightConstants.semiBold,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          characterInfo.description,
          style: TextStyle(
            fontSize: 17,
            color: ColorConstants.neutral,
            fontWeight: FontWeightConstants.semiBold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 48),
      ],
    );
  }
}
