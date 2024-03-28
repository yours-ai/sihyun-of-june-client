import 'package:flutter/material.dart';
import 'package:project_june_client/constants.dart';

class UnreadDotContainer extends StatelessWidget {
  final bool hasUnread;
  final Widget child;
  final double boxHeight;
  final double boxWidth;
  final double dotTopPosition;
  final double dotRightPosition;
  final double dotRadius;

  const UnreadDotContainer({
    super.key,
    required this.hasUnread,
    required this.child,
    this.boxHeight = 32,
    this.boxWidth = 32,
    this.dotTopPosition = 0,
    this.dotRightPosition = 5,
    this.dotRadius = 5,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: boxHeight,
      width: boxWidth,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: child,
          ),
          if (hasUnread)
            UnreadDotWidget(
              dotTopPosition: dotTopPosition,
              dotRightPosition: dotRightPosition,
              dotRadius: dotRadius,
            ),
        ],
      ),
    );
  }
}

class UnreadDotWidget extends StatelessWidget {
  final double dotTopPosition;
  final double dotRightPosition;
  final double dotRadius;

  const UnreadDotWidget({
    super.key,
    required this.dotTopPosition,
    required this.dotRightPosition,
    required this.dotRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: dotTopPosition,
      right: dotRightPosition,
      child: Container(
        height: dotRadius * 2,
        width: dotRadius * 2,
        decoration: BoxDecoration(
          color: ColorConstants.alert,
          borderRadius: BorderRadius.circular(dotRadius),
        ),
      ),
    );
  }
}
