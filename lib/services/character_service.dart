import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/actions/character/models/CharacterImage.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/widgets/character_change_modal.dart';

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

  Future<bool> checkCanRetest() async {
    final myCharactersQuery = await fetchMyCharactersQuery().result;
    final hasCharacter =
        myCharactersQuery.data != null && myCharactersQuery.data!.isNotEmpty;
    final myCharacters = myCharactersQuery.data;
    if (hasCharacter == false || myCharacters == null || myCharacters.isEmpty) {
      return true;
    }
    final allCharacters = await fetchAllCharactersQuery().result;
    final canRetest = myCharacters.length != allCharacters.data!.length;
    return canRetest;
  }

  Future<void> resetProviderOfCharacter(WidgetRef ref) async {
    final characterList = await _getCharacterListAndActiveCharacter(ref);
    if (characterList[0] == null || characterList[1] == null) {
      return;
    }
    final activeCharacter = characterList[1];
    ref.read(selectedCharacterProvider.notifier).state = activeCharacter;
  }

  Future<void> refreshProviderOfCharacter(WidgetRef ref) async {
    final characterList = await _getCharacterListAndActiveCharacter(ref);
    if (characterList[0] == null || characterList[1] == null) {
      return;
    }
    final myCharacters = characterList[0];
    if (ref.read(selectedCharacterProvider) != null) {
      final selectedCharacter = myCharacters.firstWhere(
        (character) => character.id == ref.read(selectedCharacterProvider)!.id,
        orElse: () => throw Exception('Selected character maybe be deleted.'),
      );
      ref.read(selectedCharacterProvider.notifier).state = selectedCharacter;
    }
  }

  Future<List<dynamic>> _getCharacterListAndActiveCharacter(
      WidgetRef ref) async {
    final myCharacters =
        await fetchMyCharactersQuery().refetch().then((value) => value.data);
    if (myCharacters == null || myCharacters.isEmpty) {
      ref.read(activeCharacterProvider.notifier).state = null;
      ref.read(selectedCharacterProvider.notifier).state = null;
      return [null, null];
    }
    final activeCharacter = myCharacters.firstWhere(
      (character) => character.assigned_characters!
          .any((assignedCharacter) => assignedCharacter.is_active),
      orElse: () => throw Exception('Active character not found.'),
    );
    ref.read(activeCharacterProvider.notifier).state = activeCharacter;
    return [myCharacters, activeCharacter];
  }

  void redirectRetest(WidgetRef ref, BuildContext context) async {
    final activeCharacter = ref.read(activeCharacterProvider);
    if (activeCharacter == null) return;
    final bool is30DaysFinished = await fetchMeQuery()
        .result
        .then((value) => value.data!.is_30days_finished);
    if (activeCharacter.id == ref.read(selectedCharacterProvider)?.id &&
        is30DaysFinished) {
      context.push(
        RoutePaths.retest,
        extra: <String, dynamic>{
          'firstName': activeCharacter.first_name,
        },
      );
    }
  }

  void showCharacterChangeModal({
    required List<Character> characterList,
    required BuildContext context,
    required WidgetRef ref,
  }) {
    final selectedCharacter = ref.read(selectedCharacterProvider);
    final activeCharacterFirstName =
        ref.read(activeCharacterProvider)?.first_name;
    final unselectedCharacterList = characterList
        .where((character) => character.id != selectedCharacter?.id)
        .toList();
    showModalBottomSheet(
      backgroundColor: ColorConstants.veryLightGray,
      context: context,
      showDragHandle: true,
      builder: (context) {
        return CharacterChangeModal(
          selectedCharacter: selectedCharacter,
          unselectedCharacterList: unselectedCharacterList,
          activeCharacterFirstName: activeCharacterFirstName,
        );
      },
    );
  }
}
