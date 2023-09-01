import 'package:flutter/material.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';


class MailListScreen extends StatelessWidget {
  const MailListScreen({super.key});

  @override
  Widget build(context) {
    return SafeArea(
      child: TitleLayout(
        titleText: '받은 편지함',
        body: Container(),
      )
    );
  }
}
