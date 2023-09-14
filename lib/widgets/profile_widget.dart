import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_june_client/constants.dart';
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
        Container(
          padding: const EdgeInsets.symmetric(vertical: 36.0),
          child: Text(
            '$name, $age\n$mbti',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          description ?? '',
          style: TextStyle(fontSize: 18, color: ColorConstants.neutral),
        ),
      ],
    );
  }
}
