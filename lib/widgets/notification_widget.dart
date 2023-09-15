import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:project_june_client/actions/notification/models/AppNotification.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/services.dart';

class NotificationWidget extends StatefulWidget {
  final AppNotification notification;

  const NotificationWidget({
    super.key,
    required this.notification,
  });

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.notification.is_read == false
          ? const Color.fromRGBO(236, 236, 236, 0.4)
          : ColorConstants.background,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          splashFactory: NoSplash.splashFactory,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 83,
              padding: const EdgeInsets.only(left: 22),
              alignment: Alignment.centerLeft,
              child: Text(
                widget.notification.body,
                style: TextStyle(
                    fontSize: 15,
                    color: ColorConstants.secondary,
                    fontWeight: widget.notification.is_read == false
                        ? FontWeight.bold
                        : FontWeight.normal),
              ),
            ),
            Container(
              height: 20,
              padding: const EdgeInsets.only(right: 22),
              child: Row(
                children: [
                  Text(
                    Moment(widget.notification.created).fromNow(),
                    style: TextStyle(
                        color: ColorConstants.neutral,
                        fontWeight: widget.notification.is_read == false
                            ? FontWeight.bold
                            : FontWeight.normal),
                  ),
                  Icon(
                    PhosphorIcons.caret_right,
                    size: 20,
                    color: ColorConstants.neutral,
                  ),
                ],
              ),
            ),
          ],
        ),
        onPressed: () {
          notificationService.handleClickNotification(
            widget.notification,
          );
        },
      ),
    );
  }
}
