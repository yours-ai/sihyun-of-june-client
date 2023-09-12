import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/constants.dart';

import '../actions/character/models/Character.dart';
import '../widgets/profile_widget.dart';

class CharacterChoiceScreen extends StatefulWidget {
  final Character character;
  const CharacterChoiceScreen({super.key, required this.character});

  @override
  State<StatefulWidget> createState() {
    return _CharacterChoiceScreen();
  }
}

class _CharacterChoiceScreen extends State<CharacterChoiceScreen> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Container(
            padding: const EdgeInsets.only(left: 23),
            child: Icon(
              PhosphorIcons.arrow_left,
              color: ColorConstants.black,
              size: 32,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                children: [
                  ProfileWidget(
                      Name: '류시현',
                      Age: '24',
                      MBTI: 'ESFJ',
                      Description:
                          '서울에서 심리학과를 졸업한 시현이는 되었어요. 항상 섬세하고 자주 따뜻하게 편지를 보내주어요. 항상 섬세하고',
                      ImagePath: 'assets/images/ryusihyun_profile.png'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 36.0),
                        child: Text(
                          '다른 상대도\n살펴볼까요?',
                          style: TextStyle(
                            color: ColorConstants.secondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 1.0,
                        children: [
                          GestureDetector(
                            onTap: () { context.go('/othercharacter'); },
                            child: ClipRRect(
                              child: Image.asset(
                                'assets/images/ryusihyun_profile.png',
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          ClipRRect(
                            child: Image.asset(
                              'assets/images/ryusihyun_profile.png',
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          ClipRRect(
                            child: Image.asset(
                              'assets/images/ryusihyun_profile.png',
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          ClipRRect(
                            child: Image.asset(
                              'assets/images/ryusihyun_profile.png',
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          ClipRRect(
                            child: Image.asset(
                              'assets/images/ryusihyun_profile.png',
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          ClipRRect(
                            child: Image.asset(
                              'assets/images/ryusihyun_profile.png',
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 36,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 28.0, right: 28.0, bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        context.go('/select');
                      },
                      child: Text('친구에게 자랑하기')),
                  SizedBox(
                    height: 10,
                  ),
                  FilledButton(
                      onPressed: () {
                        context.go('/select');
                      },
                      child: Text('다음')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
