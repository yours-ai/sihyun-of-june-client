import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';

import '../constants.dart';

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
