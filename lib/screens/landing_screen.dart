import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LandingScreen extends HookWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRect(
                  child: Image.asset(
                    "assets/images/landing/landing1.png",
                  ),
                ),
              ),
            ),
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  bottom: 40.0,
                  top: 30.0,
                ),
                child: FilledButton(
                  onPressed: () {},
                  child: Text(
                    '다음',
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
