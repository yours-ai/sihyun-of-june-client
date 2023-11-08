import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/dotted_underline.dart';

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
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: ColorConstants.lightGray,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 66,
                  padding: const EdgeInsets.only(left: 28),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      color: ColorConstants.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(padding: EdgeInsets.only(right: 28), child: suffix),
              ],
            ),
            const DottedUnderline(28),
          ],
        ),
      ),
    );
  }
}
