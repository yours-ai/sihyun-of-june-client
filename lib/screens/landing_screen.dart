import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LandingScreen extends HookWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 150),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              '기다려본 적 있나요?\n하루 한 통의 설렘을.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset(
              "assets/images/landing/landing1.png",
            ),
          ),
        ],
      ),
    );
  }
}
