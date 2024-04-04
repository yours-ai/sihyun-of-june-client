import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/actions/notification/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/services/unique_cachekey_service.dart';
import 'package:project_june_client/widgets/common/unread_dot.dart';
import 'package:project_june_client/widgets/common/title_underline.dart';

class TopNavbarWidget extends StatelessWidget {
  final Character selectedCharacter;
  final String titleText;

  const TopNavbarWidget({
    super.key,
    required this.selectedCharacter,
    required this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    final mainImageSrc =
        characterService.getMainImage(selectedCharacter.character_info.images);
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              Text(
                '${selectedCharacter.first_name}이와의\n${mailService.getDDay(selectedCharacter.assigned_characters!.last.first_mail_available_at)}',
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
        TitleUnderline(titleText: titleText),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () => context.push(RoutePaths.betweenRelationship),
                  child: SvgPicture.asset(
                    'assets/images/heart.svg',
                    width: 32,
                    height: 32,
                    theme: SvgTheme(
                      currentColor: ColorConstants.lightGray,
                    ),
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
                        return const SizedBox();
                      }
                      hasUnreadNotification = notificationState.data!
                          .any((notification) => !notification.is_read!);
                      return UnreadDotContainer(
                        hasUnread: hasUnreadNotification,
                        child: SvgPicture.asset(
                          'assets/images/bell.svg',
                          width: 32,
                          height: 32,
                          theme: SvgTheme(
                            currentColor: ColorConstants.lightGray,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => context.push(RoutePaths.homeMyCharacter),
                child: UnreadDotContainer(
                  hasUnread: selectedCharacter.is_image_updated!,
                  dotRightPosition: -3,
                  boxWidth: 30,
                  boxHeight: 30,
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
    );
  }
}
