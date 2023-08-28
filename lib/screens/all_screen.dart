import 'package:flutter/material.dart';

import '../widgets/common/title_layout.dart';

class AllScreen extends StatelessWidget {
  const AllScreen({super.key});

  @override
  Widget build(context) {
    return SafeArea(
        child: TitleLayout(
          titleText: '전체',
          body: Container(),
        )
    );
  }
}
