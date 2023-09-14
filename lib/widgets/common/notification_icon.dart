import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:project_june_client/constants.dart';

class NotificationIconWidget extends StatelessWidget {
  final bool hasUnread;
  final bool isActive;

  const NotificationIconWidget({
    super.key,
    required this.hasUnread,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      width: 32,
      child: Stack(
        children: [
          Positioned.fill(
            child: isActive
                ? const Icon(
                    PhosphorIcons.bell_fill,
                    size: 32,
                  )
                : const Icon(
                    PhosphorIcons.bell_light,
                    size: 32,
                  ),
          ),
          if (hasUnread) Positioned(
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
