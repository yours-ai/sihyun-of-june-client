import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/common/top_navbar.dart';

class HomeWidget extends StatelessWidget {
  final Character selectedCharacter;

  const HomeWidget(this.selectedCharacter, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TitleLayout(
        title: TopNavbarWidget(
          selectedCharacter: selectedCharacter,
          titleText: 'HOME',
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 50,
              ),
              child: Text(
                "태진이의 오늘은\n2023년 6월 22일 '맑음' ☀️",
                style: TextStyle(
                  fontFamily: 'NanumJungHagSaeng',
                  color: ColorConstants.primary,
                  fontSize: 21,
                  height: 1,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Text(
                '새 편지가 왔네\n한번 확인해봐!',
                style: TextStyle(
                  fontFamily: 'NanumJungHagSaeng',
                  color: ColorConstants.primary,
                  fontSize: 25,
                  height: 1.2,
                  letterSpacing: 1.7,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              //TODO: 나중에 유월이 이미지가 들어갈 부분임
              width: 200,
              height: 200,
              child: ExtendedImage.network(
                cacheMaxAge: CachingDuration.image,
                cacheKey: commonService.makeUniqueKey(characterService
                    .getMainImage(selectedCharacter.character_info.images)
                    .src),
                characterService
                    .getMainImage(selectedCharacter.character_info.images)
                    .src,
                fit: BoxFit.cover,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                minimumSize: Size.zero,
                backgroundColor: ColorConstants.black,
              ),
              onPressed: () {
                // TODO: 열기 및 결제 로직 추가
              },
              child: Text(
                '열기',
                style: TextStyle(
                  color: ColorConstants.background,
                  fontSize: 12,
                  fontWeight: FontWeightConstants.semiBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
