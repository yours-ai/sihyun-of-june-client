import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';

import '../../constants.dart';
import '../../screens/character_test/test_screen.dart';

class TestInfoTabData {
  final String titleText;
  final Widget body;
  final String button;

  const TestInfoTabData({
    required this.titleText,
    this.body = const SizedBox(),
    required this.button,
  });
}

List<TestInfoTabData> getTabList(String firstName) {
  return [
    TestInfoTabData(
        titleText: '이제, $firstName님과 편지를\n나눌 상대를 정해드리려 해요.',
        body:
            Center(child: Image.asset('assets/images/landing/test_image.png')),
        button: '다음'),
    TestInfoTabData(
        titleText: '그렇다면, 간단한 질문들로\n$firstName님을 알아가 볼게요 :)', button: '알겠어요!'),
  ];
}

class TestStartWidget extends StatefulWidget {
  final Function(ActiveScreen) onActiveScreen;

  const TestStartWidget({super.key, required this.onActiveScreen});

  @override
  State<StatefulWidget> createState() {
    return _TestStartWidget();
  }
}

class _TestStartWidget extends State<TestStartWidget> {
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
      appBar: AppBar(
        backgroundColor: ColorConstants.background,
        elevation: 0,
        title: const SizedBox.shrink(),
      ),
      body: SafeArea(
        child: QueryBuilder(
          query: query,
          builder: (context, state) {
            if (state.data == null) {
              return const SizedBox.shrink();
            }
            final tab = getTabList(state.data!.first_name)[_tab];
            return TitleLayout(
              withAppBar: true,
              title: Text(
                tab.titleText,
                style: Theme.of(context).textTheme.titleLarge,
                softWrap: true,
                textAlign: TextAlign.center,
              ),
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
              actions: FilledButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    ColorConstants.pink,
                  ),
                ),
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
