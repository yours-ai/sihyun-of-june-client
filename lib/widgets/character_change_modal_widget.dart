import 'dart:async';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/services.dart';

import '../actions/character/models/Character.dart';
import '../providers/character_provider.dart';
import '../providers/common_provider.dart';
import '../services/unique_cachekey_service.dart';

class CharacterChangeListWidget extends ConsumerWidget {
  final Character character;
  final bool isSelected;

  const CharacterChangeListWidget(
      {super.key, required this.character, required this.isSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        if (isSelected) return;
        characterService.changeCharacterByTap(ref, character);
        context.pop();
      },
      child: Row(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              clipBehavior: Clip.hardEdge,
              child: ExtendedImage.network(
                characterService
                    .getMainImage(character.character_info!.images!)
                    .src,
                timeLimit: ref.watch(imageCacheDurationProvider),
                cacheKey: UniqueCacheKeyService.makeUniqueKey(characterService
                    .getMainImage(character.character_info!.images!)
                    .src),
                width: 40,
                height: 40,
              ),
            ),
          ),
          Expanded(
            child: Text(
              character.name!,
              style: TextStyle(
                  fontSize: 17,
                  color: isSelected
                      ? Color(
                          ref.watch(characterThemeProvider).colors!.primary!,
                        )
                      : ColorConstants.primary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
            ),
          ),
          if (isSelected)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              child: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(
                  PhosphorIcons.check_circle_fill,
                  color:
                      Color(ref.watch(characterThemeProvider).colors!.primary!),
                  size: 32,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
