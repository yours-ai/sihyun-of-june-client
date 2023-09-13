import 'dart:async';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';

class TestResultData {
  final String title;
  final Widget body;
  final String button;

  const TestResultData({
    required this.title,
    this.body = const SizedBox(),
    required this.button,
  });
}

final List<TestResultData> tabList = [
  TestResultData(
      title: '테스트가 완료됐어요!\n상대를 정하는 중이에요...',
      body: Lottie.asset('assets/lotties/animation_lm8qjemt.zip'),
      button: '두근두근...'),
  const TestResultData(title: '상대가 정해졌어요!\n확인해보실래요?', button: '확인해보기'),
  const TestResultData(title: '오류가 발생했어요', button: '다시 하기'),
];

class TestResultWidget extends StatefulWidget {
  final List<List<num>> responses;

  final List<Map<String, dynamic>> output;

  TestResultWidget({super.key, required this.responses})
      : output = responses.map((item) {
          return {
            'question_id': item[0].toInt(),
            'choice': item[1].toInt(),
          };
        }).toList();

  @override
  State<StatefulWidget> createState() {
    return _TestResultWidget();
  }
}

class _TestResultWidget extends State<TestResultWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _switchPageAfterDelay();
    });  }

  Future<void> _switchPageAfterDelay() async {
    await Future.delayed(const Duration(seconds: 4));
    setState(() {
      _tab = 1;
    });
  }

  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: AppBar(
          backgroundColor: ColorConstants.background,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: LinearProgressIndicator(
              value: 1,
              backgroundColor: ColorConstants.background,
              valueColor:
                  AlwaysStoppedAnimation<Color>(ColorConstants.secondary),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: TitleLayout(
          titleText: tabList[_tab].title,
          body: Builder(
            builder: (context) {
              return AnimatedCrossFade(
                firstChild: tabList[0].body,
                secondChild: tabList[1].body,
                crossFadeState: _tab == 0
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 500),
              );
            },
          ),
          actions: _tab == 0
              ? OutlinedButton(
                  onPressed: () {},
                  child: Text(tabList[_tab].button,
                      style: TextStyle(color: ColorConstants.neutral)),
                )
              : _tab == 1
                  ? MutationBuilder(
                      mutation: sendResponseMutation(
                        onSuccess: (res, arg) {
                          context.go('/result');
                        },
                        onError: (arg, error, callback) {
                          setState(() {
                            _tab = 2;
                          });
                        },
                      ),
                      builder: (context, state, mutate) => FilledButton(
                            onPressed: () => {mutate(widget.output)},
                            child: Text(tabList[_tab].button)),
                    )
                  : FilledButton(
                      onPressed: () {
                        setState(() {
                          _tab = 0;
                          _switchPageAfterDelay();
                        });
                      },
                      child: Text(tabList[_tab].button)),
        ),
      ),
    );
  }
}
