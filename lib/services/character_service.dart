import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/actions/character/models/CharacterImage.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/contrib/flutter_secure_storage.dart';
import 'package:project_june_client/providers/character_provider.dart';

class CharacterService {
  const CharacterService();

  static const _CHARACTER_ID_KEY = 'CHARACTER_ID';

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

  Future<int?> getSelectedCharacterId() async {
    final storage = getSecureStorage();
    final selectedCharacterId = await storage.read(key: _CHARACTER_ID_KEY);
    if (selectedCharacterId == null) return null;
    return int.parse(selectedCharacterId);
  }

  Future<void> saveSelectedCharacterId(int selectedCharacterId) async {
    final storage = getSecureStorage();
    await storage.write(
        key: _CHARACTER_ID_KEY, value: selectedCharacterId.toString());
  }

  Future<void> deleteSelectedCharacterId() async {
    final storage = getSecureStorage();
    await storage.delete(key: _CHARACTER_ID_KEY);
  }

  void changeCharacterByTap(WidgetRef ref, Character character) async {
    saveSelectedCharacterId(character.id);
    ref.read(selectedCharacterProvider.notifier).state = character.id;
    ref.read(characterThemeProvider.notifier).state = character.theme!;
  }

  List<int> getCharacterIds(List<Character> characterList) {
    return characterList.map((character) => character.id).toList();
  }

  String getCurrentCharacterFirstName(List<Character> characterList) {
    return characterList
        .where((character) => character.is_current == true)
        .first
        .first_name!;
  }

  void redirectRetest(
      {required BuildContext currentContext,
      required WidgetRef ref}) async {
    final myCharacterList =
        await getRetrieveMyCharacterQuery().result.then((value) => value.data);
    final currentCharacter = myCharacterList!
        .where((character) => character.is_current == true)
        .first;
    final bool is30DaysFinished = await getRetrieveMeQuery()
        .result
        .then((value) => value.data!.is_30days_finished);
    if (currentCharacter.id == ref.read(selectedCharacterProvider) &&
        is30DaysFinished) {
      currentContext.push(
        "/retest",
        extra: <String, dynamic>{
          "firstName": getCurrentCharacterFirstName(myCharacterList),
          "characterIds": getCharacterIds(myCharacterList),
        },
      );
    }
  }
}
