import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/screens/profile_details_screen.dart';
import 'package:project_june_client/widgets/common/dotted_underline.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfileWidget extends StatelessWidget {
  final String? name;
  final num? age;
  final String? one_line_description;
  final String? description;
  final List<String> imageList;

  const ProfileWidget({
    super.key,
    required this.name,
    required this.age,
    required this.one_line_description,
    required this.description,
    required this.imageList,
  });

  @override
  Widget build(BuildContext context) {
    final stackedImageList =
        imageList.length > 3 ? imageList.sublist(0, 3) : imageList;
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
                    builder: (context) => ProfileDetailsScreen(imageList));
              },
              child: Transform.rotate(
                angle: angle,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: SizedBox(
                    width: 320,
                    height: 480,
                    child: FadeInImage.memoryNetwork(
                      fadeInDuration: const Duration(milliseconds: 200),
                      placeholder: kTransparentImage,
                      image: stackedImageList[index],
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
            '$name($age)',
            style: TextStyle(
              color: ColorConstants.pink,
              fontFamily: 'NanumJungHagSaeng',
              fontSize: 54,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
        ),
        Center(
          child: Text(
            '$one_line_description',
            style: TextStyle(
              color: ColorConstants.primary,
              fontFamily: 'NanumJungHagSaeng',
              fontSize: 32,
              height: 28 / 32,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description ?? '',
          style: TextStyle(
            fontSize: 17,
            color: ColorConstants.neutral,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 48),
      ],
    );
  }
}
