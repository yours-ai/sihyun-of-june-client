import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/providers/common_provider.dart';
import 'package:project_june_client/services/unique_cachekey_service.dart';

import '../actions/auth/queries.dart';
import '../actions/character/queries.dart';
import '../constants.dart';
import '../providers/character_provider.dart';
import '../screens/character_profile/profile_details_screen.dart';
import '../services.dart';

class UserProfileWidget extends ConsumerStatefulWidget {
  const UserProfileWidget({super.key});

  @override
  UserProfileWidgetState createState() => UserProfileWidgetState();
}

class UserProfileWidgetState extends ConsumerState<UserProfileWidget> {
  // void _showMultiCharacterModal() {
  //   showModalBottomSheet(
  //     backgroundColor: ColorConstants.lightGray,
  //     context: context,
  //     showDragHandle: true,
  //     builder: (context) {
  //       return Container(
  //         margin: const EdgeInsets.symmetric(horizontal: 10),
  //         height: 300,
  //         decoration: BoxDecoration(
  //           color: ColorConstants.background,
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         child: QueryBuilder( // 이거 두번이나 불러옴. 필요 없을듯
  //           query: getRetrieveMyCharacterQuery(),
  //           builder: (context, state) => Column(
  //             children: [
  //               ...state.data!
  //                   .map((character) => CharacterChangeListWidget(
  //                       character: character, isSelected: false))
  //                   .toList(),
  //               Row(
  //                 children: [
  //                   Padding(
  //                       padding: const EdgeInsets.symmetric(
  //                           horizontal: 16.0, vertical: 8.0),
  //                       child: Icon(
  //                         PhosphorIcons.plus_circle_fill,
  //                         color: ColorConstants.primary,
  //                         size: 40,
  //                       )),
  //                   Expanded(
  //                     child: Text(
  //                       '새 친구 만나기',
  //                       style: TextStyle(
  //                         fontSize: 17,
  //                         color: ColorConstants.primary,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // } //3.0작업

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        QueryBuilder(
          query: getRetrieveMyCharacterQuery(),
          builder: (context, state) {
            if (state.data != null) {
              final selectedCharacter = state.data!
                  .where((character) =>
                      character.id == ref.watch(selectedCharacterProvider))
                  .first;
              final mainImageSrc = characterService
                  .getMainImage(selectedCharacter.character_info!.images!);
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        selectedCharacter.is_image_updated!
                            ? showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => ProfileDetailsScreen(
                                  imageList:
                                      selectedCharacter.character_info!.images!,
                                  index: mainImageSrc.order - 1,
                                ),
                              )
                            : context.push('/mails/my-character');
                      },
                      // onDoubleTap: () {
                      //   context.push('/character');
                      // },
                      // onLongPress: () {
                      //   _showMultiCharacterModal();
                      // }, //3.0작업
                      child: Container(
                        padding: const EdgeInsets.all(1.5), // 내부 패딩
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70.0),
                          // 원형 테두리 반경
                          border: Border.all(
                            color: selectedCharacter.is_image_updated!
                                ? Color(ref
                                    .watch(characterThemeProvider)
                                    .colors!
                                    .primary!)
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
                              timeLimit: ref.watch(imageCacheDurationProvider),
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
                      context.push('/mails/my-character');
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 5, 0, 20),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: selectedCharacter.is_image_updated!
                                ? Color(ref
                                    .watch(characterThemeProvider)
                                    .colors!
                                    .primary!)
                                : ColorConstants.gray,
                            width: 1.0,
                          ),
                        ),
                      ), // Text에 underline을 추가하면, 한글 이슈로 빈칸과 높낮이가 안 맞음.
                      child: Text(
                          '${selectedCharacter.is_image_updated! ? '새 ' : ''}프로필 보기',
                          style: TextStyle(
                              color: selectedCharacter.is_image_updated!
                                  ? Color(ref
                                      .watch(characterThemeProvider)
                                      .colors!
                                      .primary!)
                                  : ColorConstants.gray,
                              height: 1.0)),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
        Column(
          children: [
            QueryBuilder(
              query: getRetrieveMeQuery(),
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
                                  ? Image.asset(
                                      'assets/images/default_user_image.png')
                                  : ExtendedImage.network(
                                      state.data!.image!,
                                      timeLimit:
                                          ref.watch(imageCacheDurationProvider),
                                      cacheKey:
                                          UniqueCacheKeyService.makeUniqueKey(
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
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 20),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: ColorConstants.gray,
                      width: 1.0,
                    ),
                  ),
                ), // Text에 underline을 추가하면, 한글 이슈로 빈칸과 높낮이가 안 맞음.
                child: Text('프로필 변경하기',
                    style: TextStyle(color: ColorConstants.gray, height: 1.0)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
