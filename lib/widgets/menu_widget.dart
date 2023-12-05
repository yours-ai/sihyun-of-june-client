import 'package:flutter/material.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/dotted_underline.dart';

class MenuWidget extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final VoidCallback onPressed;
  final Widget suffix;

  const MenuWidget({
    Key? key,
    this.title,
    this.titleWidget,
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
                  child: titleWidget ??
                      Text(
                        title!,
                        style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.primary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                ),
                Container(
                    padding: const EdgeInsets.only(right: 28), child: suffix),
              ],
            ),
            const DottedUnderline(28),
          ],
        ),
      ),
    );
  }
}
