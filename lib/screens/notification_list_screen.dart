import 'package:flutter/material.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';

class NotificationListScreen extends StatelessWidget {
  const NotificationListScreen({super.key});

  @override
  Widget build(context) {
    return SafeArea(
        child: TitleLayout(
          showProfile: false,
          titleText: '알림',
          body: Container(),
        )
    );
  }
}
