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
    this.titleAddOn = const SizedBox.shrink(),
    this.withAppBar = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        withAppBar ? const SizedBox(height: 10) : const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  titleText,
                  style: TextStyle(fontFamily: 'NanumJungHagSaeng', fontSize: 39, height: 36/39),
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ),
              titleAddOn
            ],
          ),
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
