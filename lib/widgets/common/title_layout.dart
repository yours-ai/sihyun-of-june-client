import 'package:flutter/material.dart';

class TitleLayout extends StatelessWidget {
  final String titleText;
  final TextStyle? titleStyle;
  final Widget body;
  final Widget? actions;
  final bool showProfile;

  const TitleLayout({
    Key? key,
    required this.titleText,
    this.titleStyle,
    required this.body,
    this.actions,
    required this.showProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                titleText,
                style: titleStyle ?? Theme.of(context).textTheme.titleLarge,
              ),
            ),
            if (showProfile)
            Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  'assets/images/ryusihyun_profile.png',
                  height: 35,
                ),
              ),
            ) else
              const SizedBox( width:0, height:0),
          ],
        ),
        const SizedBox(height: 30),
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
