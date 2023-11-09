import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/dotted_underline.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfileWidget extends StatelessWidget {
  final String? name;
  final num? age;
  final String? mbti;
  final String? description;
  final String imageSrc;

  const ProfileWidget({
    super.key,
    required this.name,
    required this.age,
    required this.mbti,
    required this.description,
    required this.imageSrc,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage.memoryNetwork(
            fadeInDuration: const Duration(milliseconds: 200),
            placeholder: kTransparentImage,
            image: imageSrc,
          ),
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
            '$mbti',
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
