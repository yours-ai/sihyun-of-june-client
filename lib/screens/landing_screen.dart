import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class LandingScreen extends HookWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 100),
          Text('기다려본 적 있나요?\n하루 한 통의 설렘을.'),
          Icon(
            PhosphorIcons.heart,
            size: 45,
          ),
          Icon(
            PhosphorIcons.heart_thin,
            size: 45,
          ),
          Icon(
            PhosphorIcons.heart_light,
            size: 45,
          ),
          Icon(
            PhosphorIcons.heart_bold,
            size: 45,
          ),
          Icon(
            PhosphorIcons.heart_fill,
            size: 45,
          ),
        ],
      ),
    );
  }
}
