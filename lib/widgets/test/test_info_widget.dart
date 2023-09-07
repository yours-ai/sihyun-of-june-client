import 'package:flutter/material.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';

import '../../screens/test_screen.dart';

class TestInfoTabData {
  final String title;
  final Widget body;
  final String button;

  const TestInfoTabData(
      {required this.title,
      this.body = const SizedBox(),
      required this.button,});
}

final List<TestInfoTabData> tabList = [
  TestInfoTabData(
      title: '먼저, 서윤님과\n한달간 편지를 나눌\n상대를 정해드리려고 해요.',
      body:
          SizedBox(child: Image.asset('assets/images/landing/landing2.png')),
      button: '그래요?'),
  const TestInfoTabData(
      title: '간단한 질문들로,\n서윤님에 대해 알아볼게요.', button: '알겠어요!'),
];

class TestInfoWidget extends StatefulWidget {

  final Function(ActiveScreen) setActiveScreen;

  TestInfoWidget({required this.setActiveScreen});

  @override
  State<StatefulWidget> createState() {
    return _TestInfoWidget();
  }
}

class _TestInfoWidget extends State<TestInfoWidget> {
  int _tab = 0;
  final PageController _controller = PageController();

  void _updateTab(int index) {
    setState(() {
      _tab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TitleLayout(
            titleText: tabList[_tab].title,
            body: Builder(builder: (context) {
              final double height = MediaQuery.of(context).size.height;
              return PageView(
                controller: _controller,
                onPageChanged: (index) {
                  _updateTab(index);
                },
                children: [
                  tabList[_tab].body,
                ],
              );
            }),
            actions: OutlinedButton(
                    onPressed: ()
                    { _tab == 0?
                      setState(() {
                        _tab++;
                      }) :
                    widget.setActiveScreen(ActiveScreen.inTest);
                    },
                    child: Text(tabList[_tab].button),
                  )),
      ),
    );
  }
}
