import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';

import '../../screens/test_screen.dart';

class TestInfoTabData {
  final String title;
  final Widget body;
  final String button;

  const TestInfoTabData({
    required this.title,
    this.body = const SizedBox(),
    required this.button,
  });
}

List<TestInfoTabData> getTabList(String firstName) {
  return [
    TestInfoTabData(
        title: '먼저, $firstName님과\n한달간 편지를 나눌\n상대를 정해드리려고 해요.',
        body:
            SizedBox(child: Image.asset('assets/images/landing/landing2.png')),
        button: '그래요?'),
    TestInfoTabData(
        title: '간단한 질문들로,\n$firstName님에 대해 알아볼게요.', button: '알겠어요!'),
  ];
}

class TestStartWidget extends StatefulWidget {
  final Function(ActiveScreen) onActiveScreen;

  const TestStartWidget({super.key, required this.onActiveScreen});

  @override
  State<StatefulWidget> createState() {
    return _TestInfoWidget();
  }
}

class _TestInfoWidget extends State<TestStartWidget> {
  int _tab = 0;
  final PageController _controller = PageController();

  void _updateTab(int index) {
    setState(() {
      _tab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final query = getRetrieveMeQuery();

    return Scaffold(
      body: SafeArea(
        child: QueryBuilder(
          query: query,
          builder: (context, state) {
            if (state.data == null) {
              return const SizedBox.shrink();
            }
            final tab = getTabList(state.data!.first_name)[_tab];
            return TitleLayout(
              titleText: tab.title,
              body: Builder(builder: (context) {
                return PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    _updateTab(index);
                  },
                  children: [
                    tab.body,
                  ],
                );
              }),
              actions: OutlinedButton(
                onPressed: () {
                  _tab == 0
                      ? setState(() {
                          _tab++;
                        })
                      : widget.onActiveScreen(ActiveScreen.inTest);
                },
                child: Text(tab.button),
              ),
            );
          },
        ),
      ),
    );
  }
}
