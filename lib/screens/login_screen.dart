import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:project_june_client/constants.dart';

import '../actions/character/queries.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(children: [
                const SizedBox(height: 350),
                Image.asset(
                  'assets/images/logo.png',
                  height: 75,
                ),
              ]),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilledButton(
                      onPressed: () {
                        print('apple login clicked');
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //apple material icon
                          Icon(Icons.apple),
                          SizedBox(width: 8),
                          Text('Apple로 계속하기')
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFFFFE500),
                        foregroundColor: ColorConstants.primary,
                      ),
                      onPressed: () {
                        print('kakao login clicked');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //apple material icon
                          Image.asset(
                            'assets/images/kakao_icon.png',
                            height: 15,
                          ),
                          const SizedBox(width: 8),
                          const Text('카카오로 계속하기')
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        print('phone login clicked');
                      },
                      child: const Text('전화번호로 계속하기'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
