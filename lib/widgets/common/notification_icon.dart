import 'package:flutter/material.dart';
import 'package:project_june_client/constants.dart';

class NotificationIconWidget extends StatelessWidget {
  final bool hasUnread;
  final Widget icon;

  const NotificationIconWidget({
    super.key,
    required this.hasUnread,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      width: 32,
      child: Stack(
        children: [
          Positioned.fill(
            child: icon,
          ),
          if (hasUnread)
            Positioned(
              top: 0,
              right: 5,
              child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  color: ColorConstants.alert,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
