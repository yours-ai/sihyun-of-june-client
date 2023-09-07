import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:project_june_client/widgets/profile_widget.dart';

import '../constants.dart';

class OtherCharacterScreen extends StatelessWidget {
  const OtherCharacterScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
