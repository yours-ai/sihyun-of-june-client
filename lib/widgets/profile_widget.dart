import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_june_client/constants.dart';

class ProfileWidget extends StatelessWidget {
  final String? Name;
  final num? Age;
  final String? MBTI;
  final String? Description;
  final String ImagePath;

  ProfileWidget({
    super.key,
    required this.Name,
    required this.Age,
    required this.MBTI,
    required this.Description,
    required this.ImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            ImagePath,
          ),
        ),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 36.0),
            child: Text(
              '$Name, $Age\n$MBTI',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )),
        Container(
            child: Text(
          Description ?? '',
          style: TextStyle(fontSize: 18, color: ColorConstants.neutral),
        )),
      ],
    );
  }
}
