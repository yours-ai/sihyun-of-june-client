import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/actions/character/models/CharacterImage.dart';
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

  Future<int?> getSelectedCharacterId(String storageKey) async {
    final storage = getSecureStorage();
    final selectedCharacterId = await storage.read(key: storageKey);
    if (selectedCharacterId == null) return null;
    return int.parse(selectedCharacterId);
  }

  Future<void> saveSelectedCharacterId(
      {required int selectedCharacterId, required String storageKey}) async {
    final storage = getSecureStorage();
    await storage.write(key: storageKey, value: selectedCharacterId.toString());
  }

  Future<void> deleteSelectedCharacterId(String storageKey) async {
    final storage = getSecureStorage();
    await storage.delete(key: storageKey);
  }

  void changeCharacterByDoubleTap(
      WidgetRef ref, List<Character> characterList) async {
    if (ref.read(beforeSelectedCharacterProvider) == null) {
      final notSelectedCharacterList = characterList.where(
          (character) => character.id != ref.watch(selectedCharacterProvider));
      if (notSelectedCharacterList.isNotEmpty) {
        await saveSelectedCharacterId(
            selectedCharacterId: notSelectedCharacterList.first.id,
            storageKey: 'CHARACTER_ID');
        await saveSelectedCharacterId(
          selectedCharacterId: ref.read(selectedCharacterProvider)!,
          storageKey: 'BEFORE_CHARACTER_ID',
        );
        ref.read(beforeSelectedCharacterProvider.notifier).state =
            await getSelectedCharacterId('BEFORE_CHARACTER_ID');
        ref.read(selectedCharacterProvider.notifier).state =
            notSelectedCharacterList.first.id;
        ref.read(characterThemeProvider.notifier).state = characterList
            .where((character) =>
                character.id == ref.watch(selectedCharacterProvider))
            .first
            .theme!;
      }
      return;
    }
    await saveSelectedCharacterId(
        selectedCharacterId: ref.read(beforeSelectedCharacterProvider)!,
        storageKey: 'CHARACTER_ID');
    await saveSelectedCharacterId(
      selectedCharacterId: ref.read(selectedCharacterProvider)!,
      storageKey: 'BEFORE_CHARACTER_ID',
    );
    ref.read(beforeSelectedCharacterProvider.notifier).state =
        await getSelectedCharacterId('BEFORE_CHARACTER_ID');
    final changeCharacterId = await getSelectedCharacterId('CHARACTER_ID');
    ref.read(selectedCharacterProvider.notifier).state = changeCharacterId!;
    ref.read(characterThemeProvider.notifier).state = characterList
        .where((character) => character.id == changeCharacterId)
        .first
        .theme!;
  }

  void changeCharacterByTap(WidgetRef ref, Character character) async {
    saveSelectedCharacterId(
        selectedCharacterId: character.id, storageKey: 'CHARACTER_ID');
    saveSelectedCharacterId(
      selectedCharacterId: ref.read(selectedCharacterProvider)!,
      storageKey: 'BEFORE_CHARACTER_ID',
    );
    ref.read(beforeSelectedCharacterProvider.notifier).state =
        ref.read(selectedCharacterProvider)!;
    ref.read(selectedCharacterProvider.notifier).state = character.id;
    ref.read(characterThemeProvider.notifier).state = character.theme!;
  }
}
