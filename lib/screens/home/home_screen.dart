import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/actions/notification/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/services/unique_cachekey_service.dart';
import 'package:project_june_client/widgets/common/notification_icon.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/common/title_underline.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: QueryBuilder(
        query: fetchMyCharacterQuery(),
        builder: (context, charactersState) {
          if (charactersState.data == null) {
            return const SizedBox();
          }
          final selectedCharacterList = charactersState.data!.where(
              (character) =>
                  character.id == ref.watch(selectedCharacterProvider));
          if (selectedCharacterList.isEmpty) {
            if (charactersState.data!.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ref.read(selectedCharacterProvider.notifier).state =
                    charactersState.data!.first.id;
              });
            }
            return const SizedBox();
          }
          final selectedCharacter = selectedCharacterList.first;
          final mainImageSrc = characterService
              .getMainImage(selectedCharacter.character_info.images);
          return TitleLayout(
            title: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        '${selectedCharacter.first_name}이와의\n${mailService.getDDay(selectedCharacter.date_allocated!.last)}',
                        style: TextStyle(
                          fontFamily: 'NanumJungHagSaeng',
                          color: ColorConstants.primary,
                          fontSize: 21,
                          height: 15 / 18.5,
                          letterSpacing: 2,
                          fontWeight: FontWeightConstants.semiBold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                const TitleUnderline(titleText: 'HOME'),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () =>
                              context.push(RoutePaths.betweenRelationship),
                          child: Icon(
                            PhosphorIcons.heart_fill,
                            size: 30,
                            color: ColorConstants.gray,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.push(RoutePaths.notificationList),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: QueryBuilder(
                              query: fetchNotificationListQuery(),
                              builder: (context, notificationState) {
                                late bool hasUnreadNotification;
                                if (notificationState.data == null) {
                                  hasUnreadNotification = false;
                                }
                                hasUnreadNotification = notificationState.data!
                                    .any((notification) =>
                                        !notification.is_read!);
                                return NotificationIconWidget(
                                  icon: Icon(
                                    PhosphorIcons.bell_simple_fill,
                                    size: 30,
                                    color: ColorConstants.gray,
                                  ),
                                  hasUnread: hasUnreadNotification,
                                );
                              }),
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            context.push(RoutePaths.mailListMyCharacter),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35.0),
                            border: Border.all(
                              color: ColorConstants.background,
                              width: 2.0,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: ExtendedImage.network(
                                cacheMaxAge: CachingDuration.image,
                                cacheKey: UniqueCacheKeyService.makeUniqueKey(
                                    mainImageSrc.src),
                                mainImageSrc.src,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 50,
                  ),
                  child: Text(
                    "태진이의 오늘은\n2023년 6월 22일 '맑음' ☀️",
                    style: TextStyle(
                      fontFamily: 'NanumJungHagSaeng',
                      color: ColorConstants.primary,
                      fontSize: 21,
                      height: 1,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Text(
                    '새 편지가 왔네\n한번 확인해봐!',
                    style: TextStyle(
                      fontFamily: 'NanumJungHagSaeng',
                      color: ColorConstants.primary,
                      fontSize: 25,
                      height: 1.2,
                      letterSpacing: 1.7,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 200,
                  child: ExtendedImage.network(
                    cacheMaxAge: CachingDuration.image,
                    cacheKey: UniqueCacheKeyService.makeUniqueKey(
                        mainImageSrc.src),
                    mainImageSrc.src,
                    fit: BoxFit.cover,
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 7,
                    ),
                    minimumSize: Size.zero,
                    backgroundColor:
                         ColorConstants.black,
                  ),
                  onPressed: () {
                   //TODO: 메일 열기 로직
                  },
                  child: Text(
                    '열기',
                    style: TextStyle(
                      color: ColorConstants.background,
                      fontSize: 12,
                      fontWeight: FontWeightConstants.semiBold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
