import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:project_june_client/constants.dart';

class NotificationWidget extends StatefulWidget {
  final String title;
  final int time;

  NotificationWidget(
      {super.key,
      required this.time,
      required this.title});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  bool _isRead = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _isRead == false
          ? Color.fromRGBO(236, 236, 236, 0.4)
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
              padding: EdgeInsets.only(left: 22),
              alignment: Alignment.centerLeft,
              child: Text(
                widget.title,
                style: TextStyle(
                    fontSize: 15,
                    color: ColorConstants.secondary,
                    fontWeight:
                        _isRead == false ? FontWeight.bold : FontWeight.normal),
              ),
            ),
            Container(
              height: 20,
              padding: EdgeInsets.only(right: 22),
              child: Row(
                children: [
                  Text(
                    '11시간 전',
                    style: TextStyle(
                        color: ColorConstants.neutral,
                        fontWeight: _isRead == false
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
          setState(() {
            _isRead = !_isRead;
          });
        },
      ),
    );
  }
}
