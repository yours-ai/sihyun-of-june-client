import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/actions/character/models/CharacterImage.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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

  CharacterImage getMainImage(List<CharacterImage> imageList) {
    final mainImageList =
        imageList.where((image) => image.is_main == true).toList();
    return mainImageList.first;
  }

  List<Widget> addBlur() {
    return [
      Positioned.fill(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      Positioned.fill(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ),
    ];
  }

  List<int> getCharacterIds(List<Character> characterList) {
    return characterList.map((character) => character.id).toList();
  }

  Future<bool> checkEnableToRetest() async {
    final myCharactersQuery = await fetchMyCharactersQuery().result;
    final hasCharacter =
        myCharactersQuery.data != null && myCharactersQuery.data!.isNotEmpty;
    final myCharacters = myCharactersQuery.data;
    if (hasCharacter == false || myCharacters == null || myCharacters.isEmpty) {
      return true;
    }
    final allCharacters = await fetchAllCharactersQuery().result;
    final isEnableToRetest = myCharacters.length != allCharacters.data!.length;
    return isEnableToRetest;
  }

  Future<void> refreshActiveCharacter(WidgetRef ref) async {
    final myCharactersRawData = await fetchMyCharactersQuery().result;
    if (myCharactersRawData.error != null) {
      Sentry.captureException(myCharactersRawData.error!);
      return;
    }
    final myCharacters = myCharactersRawData.data;
    if (myCharacters == null || myCharacters.isEmpty) {
      ref.read(activeCharacterProvider.notifier).state = null;
      ref.read(selectedCharacterProvider.notifier).state = null;
      return;
    }
    final activeCharacter = myCharacters.firstWhere(
      (character) => character.assigned_characters!
          .any((assignedCharacter) => assignedCharacter.is_active),
      orElse: () => throw Exception('Active character not found.'),
    );
    ref.read(activeCharacterProvider.notifier).state = activeCharacter;
    ref.read(selectedCharacterProvider.notifier).state = activeCharacter;
  }
}
