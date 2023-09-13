import 'package:flutter/material.dart';
import 'package:project_june_client/constants.dart';

class MenuWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const MenuWidget({
    Key? key,
    required this.title,
    this.onPressed = defaultOnPressed,
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
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
