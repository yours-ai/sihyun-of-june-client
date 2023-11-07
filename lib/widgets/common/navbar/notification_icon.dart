import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:project_june_client/constants.dart';

class NotificationIconWidget extends StatelessWidget {
  final bool hasUnread;

  const NotificationIconWidget({
    super.key,
    required this.hasUnread,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      width: 32,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/navbar/bell.png',
              height: 32,
            ),
          ),
          if (hasUnread)
            Positioned(
              top: 3,
              right: 5,
              child: Container(
                height: 7,
                width: 7,
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
