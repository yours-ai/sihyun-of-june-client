import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:project_june_client/actions/character/models/CharacterColors.dart';
import 'package:project_june_client/actions/notification/models/AppNotification.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/common/dotted_underline.dart';

class NotificationWidget extends StatefulWidget {
  final AppNotification notification;
  final CharacterColors characterColors;

  const NotificationWidget({
    super.key,
    required this.notification,
    required this.characterColors,
  });

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        notificationService.handleClickNotification(
          redirectLink: widget.notification.link,
          notificationId: widget.notification.id,
          context: context,
          characterColors: widget.characterColors,
          payload: widget.notification.payload,
        );
      },
      child: Container(
        color: widget.notification.is_read == false
            ? ColorConstants.veryLightGray
            : ColorConstants.background,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 81,
                    padding: const EdgeInsets.only(left: 22),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.notification.body,
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorConstants.primary,
                        fontWeight: widget.notification.is_read == false
                            ? FontWeightConstants.semiBold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 110,
                  padding: const EdgeInsets.only(right: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        Moment(widget.notification.created).fromNow(),
                        style: TextStyle(
                            color: ColorConstants.primary,
                            fontSize: 12,
                            fontWeight: widget.notification.is_read == false
                                ? FontWeightConstants.semiBold
                                : FontWeight.normal),
                      ),
                      Icon(
                        PhosphorIcons.caret_right,
                        size: 24,
                        color: ColorConstants.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const DottedUnderline(22),
          ],
        ),
      ),
    );
  }
}
