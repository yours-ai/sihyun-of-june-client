import 'package:flutter/material.dart';
import 'package:project_june_client/constants.dart';

class MenuWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Widget suffix;

  const MenuWidget({
    Key? key,
    required this.title,
    this.onPressed = defaultOnPressed,
    this.suffix = const SizedBox.shrink(),
  }) : super(key: key);

  static void defaultOnPressed() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.background,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          splashFactory: NoSplash.splashFactory,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 83,
              padding: const EdgeInsets.only(left: 28),
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 18,
                    color: ColorConstants.black,
                    fontWeight: FontWeight.normal),
              ),
            ),
            Container(padding: EdgeInsets.only(right: 28), child: suffix),
          ],
        ),
      ),
    );
  }
}
