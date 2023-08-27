import 'package:flutter/material.dart';

class ProjFilledButton extends StatelessWidget {
  const ProjFilledButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {},
      child: Text('다음'),
      style: ElevatedButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        padding: const EdgeInsets.symmetric(
          vertical: 17.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
