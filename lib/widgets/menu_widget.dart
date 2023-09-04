import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/modal_widget.dart';

class MenuWidget extends HookWidget {
  final String title;
  final VoidCallback onPressed;

  MenuWidget({
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
              padding: EdgeInsets.only(left: 28),
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
