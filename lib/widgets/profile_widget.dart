import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/character/models/CharacterInfo.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/providers/common_provider.dart';
import 'package:project_june_client/screens/character_profile/profile_details_screen.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/services/unique_cachekey_service.dart';

import '../actions/character/queries.dart';

class ProfileWidget extends ConsumerStatefulWidget {
  final int id;
  final String? name;
  final CharacterInfo characterInfo;
  final Color primaryColor;

  const ProfileWidget({
    super.key,
    required this.id,
    required this.name,
    required this.characterInfo,
    required this.primaryColor,
  });

  @override
  ProfileWidgetState createState() => ProfileWidgetState();
}

class ProfileWidgetState extends ConsumerState<ProfileWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getReadCharacterStoryMutation(
        refetchQueries: ['my-character'],
        onError: (arr, err, fallback) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('프로필을 불러오지 못했습니다. 에러가 계속되면 고객센터에 문의해주세요.'),
            ),
          );
        },
      ).mutate(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final stackedImageList =
        characterService.selectStackedImageList(widget.characterInfo.images!);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          alignment: Alignment.center,
          children: List.generate(stackedImageList.length, (index) {
            // 각 이미지를 5도씩 회전시키기 위한 각도 계산
            final angle =
                -5 * ((stackedImageList.length - 1) / 2 - index) * 3.14 / 360;
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => ProfileDetailsScreen(
                      imageList: widget.characterInfo.images!,
                      id: widget.id,
                      index: stackedImageList[index].order - 1),
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
                          stackedImageList[index].src),
                      stackedImageList[index].src,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        Center(
          child: Text(
            '${widget.name}(${widget.characterInfo.age})',
            style: TextStyle(
              color: widget.primaryColor,
              fontFamily: 'NanumJungHagSaeng',
              fontSize: 54,
              fontWeight: FontWeightConstants.semiBold,
              letterSpacing: 2,
            ),
          ),
        ),
        Center(
          child: Text(
            '${widget.characterInfo.one_line_description}',
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
          widget.characterInfo.description!,
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
