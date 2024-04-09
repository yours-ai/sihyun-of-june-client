import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/actions/character/models/CharacterImage.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/contrib/flutter_secure_storage.dart';
import 'package:project_june_client/providers/character_provider.dart';

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

  Future<void> _saveSelectedCharacterId(int selectedCharacterId) async {
    final storage = getSecureStorage();
    await storage.write(
        key: StorageKeyConstants.characterId, value: selectedCharacterId.toString());
  }

  void changeCharacterByTap(WidgetRef ref, Character character) async {
    _saveSelectedCharacterId(character.id);
    ref.read(selectedCharacterProvider.notifier).state = character.id;
    ref.read(characterThemeProvider.notifier).state = character.theme;
    ref.read(selectedAssignProvider.notifier).state =
        character.assigned_characters!.last.assigned_character_id;
  }

  List<int> getCharacterIds(List<Character> characterList) {
    return characterList.map((character) => character.id).toList();
  }

  String getCurrentCharacterFirstName(List<Character> characterList) {
    final currentCharacterList =
        characterList.where((character) => character.is_current == true);
    if (currentCharacterList.isEmpty) return '';
    return characterList
        .where((character) => character.is_current == true)
        .first
        .first_name;
  }

  Future<bool> checkEnableToRetest() async {
    final myCharactersQuery = await fetchMyCharacterQuery().result;
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
}
