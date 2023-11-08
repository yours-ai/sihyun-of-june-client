import 'package:dotted_decoration/dotted_decoration.dart';
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
          ? ColorConstants.lightGray
          : ColorConstants.background,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              notificationService.handleClickNotification(
                widget.notification,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 81,
                  padding: const EdgeInsets.only(left: 22),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.notification.body,
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorConstants.primary,
                      fontWeight: widget.notification.is_read == false
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
                Container(
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
                                ? FontWeight.bold
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
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 22),
            height: 2,
            decoration: DottedDecoration(
              shape: Shape.line,
              linePosition: LinePosition.top,
              color: ColorConstants.neutral,
              dash: const [5, 5],
              strokeWidth: 1,
            ),
          ),
        ],
      ),
    );
  }
}
