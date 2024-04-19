import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/retest/retest_modal_widget.dart';

import '../actions/auth/queries.dart';
import '../actions/character/models/character.dart';
import '../constants.dart';
import 'character_change_list_widget.dart';

class CharacterChangeModal extends StatelessWidget {
  final Character? selectedCharacter;
  final List<Character> unselectedCharacterList;
  final String? activeCharacterFirstName;

  const CharacterChangeModal({
    super.key,
    required this.selectedCharacter,
    required this.unselectedCharacterList,
    required this.activeCharacterFirstName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: ColorConstants.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (selectedCharacter != null)
            CharacterChangeListWidget(
              character: selectedCharacter!,
              isSelected: true,
            ),
          ...unselectedCharacterList
              .map(
                (character) => CharacterChangeListWidget(
                  character: character,
                  isSelected: false,
                ),
              )
              .toList(),
          QueryBuilder(
            query: fetchMeQuery(),
            builder: (context, state) {
              if (state.data == null) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }
              return GestureDetector(
                onTap: () async {
                  if (activeCharacterFirstName == null) {
                    context.go(RoutePaths.assignment);
                    return;
                  }
                  if (state.data!.is_30days_finished == false) {
                    final canRetest = await characterService.checkCanRetest();
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => RetestModalWidget(
                        firstName: activeCharacterFirstName,
                        canRetest: canRetest,
                      ),
                    );
                    return;
                  }
                  context.push(
                    RoutePaths.retest,
                    extra: {'firstName': activeCharacterFirstName},
                  );
                },
                child: Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 13.5,
                          vertical: 8.0,
                        ),
                        child: Icon(
                          PhosphorIcons.plus_circle_fill,
                          color: ColorConstants.primary,
                          size: 45,
                        )),
                    Expanded(
                      child: Text(
                        '새 친구 만나기',
                        style: TextStyle(
                          fontSize: 17,
                          color: ColorConstants.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
