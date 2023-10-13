import 'package:flutter/material.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';

class NameChangeScreen extends StatelessWidget {
  const NameChangeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child : TitleLayout(
          titleText: "어떻게\n불러드릴까요?",
          body:Container(),
        )
      )
    );
  }
}