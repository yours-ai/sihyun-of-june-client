import 'package:flutter/material.dart';
import 'package:project_june_client/widgets/common/back_appbar.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/common/title_underline.dart';
import 'package:project_june_client/widgets/common/menu/menu_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppbar(),
      body: SafeArea(
        child: TitleLayout(
          withAppBar: true,
          title: const Center(
            child: TitleUnderline(
              titleText: '약관 및 정책',
            ),
          ),
          body: Column(
            children: [
              const SizedBox(height: 16),
              MenuWidget(
                onPressed: () {
                  launchUrl(Uri.parse(Urls.terms));
                },
                title: '이용약관',
              ),
              MenuWidget(
                onPressed: () {
                  launchUrl(Uri.parse(Urls.privacy));
                },
                title: '개인정보 처리방침',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
