import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_june_client/actions/character/models/CharacterImage.dart';

class CharacterService {
  const CharacterService();

  List<CharacterImage> selectStackedImageList(List<CharacterImage> imageList) {
    final revealedImageList =
        imageList.where((image) => image.is_blurred == false).toList();
    if (revealedImageList.length >= 3) {
      return revealedImageList.sublist(revealedImageList.length - 3);
    }
    return List.from(imageList.sublist(0, 3 - revealedImageList.length))
      ..addAll(revealedImageList);
  }

  String getMainImage(List<CharacterImage> imageList) {
    final mainImageList =
        imageList.where((image) => image.is_main == true).toList();
    return mainImageList.first.src!;
  }

  Widget addBlur(bool isBlurred) {
    if (isBlurred == false) {
      return const SizedBox.shrink();
    }
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }
}
