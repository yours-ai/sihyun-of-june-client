import 'package:flutter/material.dart';

class TitleLayout extends StatelessWidget {
  final String titleText;
  final TextStyle? titleStyle;
  final Widget body;
  final Widget? actions;
  final Widget titleAddOn;
  final bool withAppBar;

  const TitleLayout({
    Key? key,
    required this.titleText,
    this.titleStyle,
    required this.body,
    this.actions,
    this.titleAddOn = const SizedBox(width: 0, height: 0),
    this.withAppBar = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        withAppBar ? const SizedBox(height: 10) : const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Text(
                  titleText,
                  style: titleStyle ?? Theme.of(context).textTheme.titleLarge,
                  softWrap: true,
                ),
              ),
            ),
            Container(padding: EdgeInsets.only(right: 28), child: titleAddOn),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: body,
        ),
        if (actions != null)
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 20.0,
              ),
              child: actions,
            ),
          ),
      ],
    );
  }
}
