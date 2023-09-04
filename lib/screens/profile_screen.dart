import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:project_june_client/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/ryusihyun_profile.png',
              ),
            ),
            Container(
                padding: const EdgeInsets.symmetric(vertical: 36.0),
                child: Text(
                  '류시현, 24\nESFJ',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )),
            Container(
                child: Text(
              '서울에서 심리학과를 졸업한 시현이는 되었어요. 항상 섬세하고 자주 따뜻하게 편지를 보내주어요. 항상 섬세하고',
              style: TextStyle(fontSize: 18, color: ColorConstants.neutral),
            )),
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
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    child: Image.asset(
                      'assets/images/ryusihyun_profile.png',
                    ),
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
            FilledButton(onPressed: () {}, child: Text('친구에게 자랑하기')),
          ],
        ),
      ),
    );
  }
}
