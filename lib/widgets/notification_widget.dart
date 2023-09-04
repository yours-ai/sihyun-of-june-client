import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/modal_widget.dart';

class NotificationWidget extends HookWidget {
  final String title;
  final int time;
  NotificationWidget(
      {super.key,
      required this.time,
      required this.title});

  @override
  Widget build(BuildContext context) {
    final isRead = useState(false);
    return Container(
      color: isRead.value == false
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
                title,
                style: TextStyle(
                    fontSize: 15,
                    color: ColorConstants.secondary,
                    fontWeight:
                        isRead.value == false ? FontWeight.bold : FontWeight.normal),
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
                        fontWeight: isRead.value == false
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
          isRead.value = !isRead.value;
        },
      ),
    );
  }
}
