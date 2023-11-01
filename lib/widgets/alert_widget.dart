import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AlertWidget extends StatelessWidget {
  final String title;
  final Widget? content;
  final String confirmText;

  const AlertWidget(
      {super.key,
      required this.title,
      required this.content,
      required this.confirmText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(confirmText),
        ),
      ],
    );
  }
}
