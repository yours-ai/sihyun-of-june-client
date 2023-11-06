import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';

import '../../constants.dart';
import '../../screens/test_screen.dart';

class TestInfoTabData {
  final Widget title;
  final Widget body;
  final String button;

  const TestInfoTabData({
    required this.title,
    this.body = const SizedBox(),
    required this.button,
  });
}

List<TestInfoTabData> getTabList(context, String firstName) {
  return [
    TestInfoTabData(
        title: Text(
          '이제, $firstName님과 편지를\n나눌 상대를 정해드리려 해요.',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: ColorConstants.primary),
          softWrap: true,
          textAlign: TextAlign.center,
        ),
        body: Center(child: Image.asset('assets/images/landing/landing4.png')),
        button: '다음'),
    TestInfoTabData(
        title: Text(
          '간단한 질문들로\n$firstName님을 알아가 볼게요 :)',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: ColorConstants.primary),
          softWrap: true,
          textAlign: TextAlign.center,
        ),
        body: Container(),
        button: '알겠어요!'),
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
        title: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Center(
            child: Text(
              '편지를 받을 준비가 거의 끝났어요!',
              style: TextStyle(
                fontSize: 16,
                color: ColorConstants.neutral,
                fontFamily: 'Pretendard',
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: QueryBuilder(
          query: query,
          builder: (context, state) {
            if (state.data == null) {
              return const SizedBox.shrink();
            }
            final tab = getTabList(context, state.data!.first_name)[_tab];
            return TitleLayout(
              withAppBar: true,
              title: tab.title,
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
