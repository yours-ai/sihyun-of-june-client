import 'package:flutter/material.dart';

class TitleLayout extends StatelessWidget {
  final String titleText;
  final TextStyle? titleStyle;
  final Widget body;
  final Widget actions;

  const TitleLayout({
    Key? key,
    required this.titleText,
    this.titleStyle,
    required this.body,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            titleText,
            style: titleStyle ?? Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 30),
        Expanded(
          child: body,
        ),
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
