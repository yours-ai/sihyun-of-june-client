import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/actions/character/models/CharacterImage.dart';
import 'package:project_june_client/services/unique_cachekey_service.dart';

import '../constants.dart';
import '../providers/character_provider.dart';
import '../services.dart';
import 'character_change_modal.dart';

class UserProfileWidget extends ConsumerStatefulWidget {
  final Query retrieveMyCharacterQuery, retrieveMeQuery;

  const UserProfileWidget(this.retrieveMyCharacterQuery, this.retrieveMeQuery,
      {super.key});

  @override
  UserProfileWidgetState createState() => UserProfileWidgetState();
}

class UserProfileWidgetState extends ConsumerState<UserProfileWidget> {
  void _showMultiCharacterModal(List<Character> characterList) {
    showModalBottomSheet(
      backgroundColor: ColorConstants.veryLightGray,
      context: context,
      showDragHandle: true,
      builder: (context) {
        return CharacterChangeModal(characterList: characterList);
      },
    );
  } //3.0작업

  @override
  Widget build(BuildContext context) {
    return QueryBuilder(
        query: widget.retrieveMyCharacterQuery,
        builder: (context, state) {
          if (state.status != QueryStatus.success) {
            return const SizedBox(
              height: 184,
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          }
          late final Character? selectedCharacter;
          late final CharacterImage? mainImageSrc;
          if (state.data != null && state.data!.isNotEmpty) {
            selectedCharacter = state.data!
                .where((character) =>
                    character.id == ref.watch(selectedCharacterProvider))
                .first;
            mainImageSrc = characterService
                .getMainImage(selectedCharacter!.character_info.images);
          } else {
            selectedCharacter = null;
            mainImageSrc = null;
          }
          return Row(
            mainAxisAlignment:
                (selectedCharacter != null && mainImageSrc != null)
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.center,
            children: [
              if (selectedCharacter != null && mainImageSrc != null)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () => context.push(RoutePaths.mailListMyCharacter),
                        onLongPressStart: (_) {
                          HapticFeedback.heavyImpact();
                        },
                        onLongPressEnd: (_) {
                          HapticFeedback.heavyImpact();
                          _showMultiCharacterModal(state.data!);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(1.5), // 내부 패딩
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(70.0),
                            // 원형 테두리 반경
                            border: Border.all(
                              color: selectedCharacter.is_image_updated!
                                  ? Color(ref
                                      .watch(characterThemeProvider)
                                      .colors
                                      .primary)
                                  : ColorConstants.background,
                              // 테두리 색상
                              width: 4.0, // 테두리 두께
                            ),
                          ),
                          child: ClipRRect(
                            clipBehavior: Clip.hardEdge,
                            borderRadius: BorderRadius.circular(66),
                            child: SizedBox(
                              width: 132,
                              height: 132,
                              child: ExtendedImage.network(
                                mainImageSrc.src,
                                cacheMaxAge: CachingDuration.image,
                                cacheKey: UniqueCacheKeyService.makeUniqueKey(
                                    mainImageSrc.src),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.push(RoutePaths.mailListMyCharacter);
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: selectedCharacter.is_image_updated!
                                  ? Color(ref
                                      .watch(characterThemeProvider)
                                      .colors
                                      .primary)
                                  : ColorConstants.gray,
                              width: 1.0,
                            ),
                          ),
                        ), // Text에 underline을 추가하면, 한글 이슈로 빈칸과 높낮이가 안 맞음.
                        child: Text(
                            '${selectedCharacter.is_image_updated! ? '새로운 ' : ''}사진 확인하기',
                            style: TextStyle(
                                color: selectedCharacter.is_image_updated!
                                    ? Color(ref
                                        .watch(characterThemeProvider)
                                        .colors
                                        .primary)
                                    : ColorConstants.gray,
                                height: 1.0)),
                      ),
                    ),
                  ],
                ),
              Column(
                children: [
                  QueryBuilder(
                    query: widget.retrieveMeQuery,
                    builder: (context, state) => state.data == null
                        ? const SizedBox.shrink()
                        : Center(
                            child: Container(
                              padding: const EdgeInsets.all(5.5),
                              child: GestureDetector(
                                onTap: () {
                                  userProfileService.showChangeImageModal(
                                      context, ref);
                                },
                                child: ClipRRect(
                                  clipBehavior: Clip.hardEdge,
                                  borderRadius: BorderRadius.circular(66),
                                  child: SizedBox(
                                    width: 132,
                                    height: 132,
                                    child: state.data!.image == null
                                        ? ExtendedImage.asset(
                                            'assets/images/default_user_image.png')
                                        : ExtendedImage.network(
                                            state.data!.image!,
                                            cacheMaxAge: CachingDuration.image,
                                            cacheKey: UniqueCacheKeyService
                                                .makeUniqueKey(
                                                    state.data!.image!),
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                  GestureDetector(
                    onTap: () {
                      userProfileService.showChangeImageModal(context, ref);
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: ColorConstants.gray,
                            width: 1.0,
                          ),
                        ),
                      ), // Text에 underline을 추가하면, 한글 이슈로 빈칸과 높낮이가 안 맞음.
                      child: Text('프로필 변경하기',
                          style: TextStyle(
                              color: ColorConstants.gray, height: 1.0)),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
