import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_june_client/actions/character/actions.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import '../../actions/character/models/Character.dart';

class TestResultData {
  final String title;
  final Widget body;
  final Widget button;

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
    button: OutlinedButton(
      onPressed: () {},
      child: Text(
        '두근두근...',
        style: TextStyle(color: ColorConstants.neutral),
      ),
    ),
  ),
  TestResultData(
      title: '상대가 정해졌어요!\n확인해보실래요?',
      button: FilledButton(onPressed: () {}, child: Text('확인해보기'))),
  TestResultData(
      title: '오류가 발생했어요',
      button: FilledButton(onPressed: () {}, child: Text('다시하기'))),
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
  late PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _sendAnswers();
    _pageController = PageController();

    _switchPageAfterDelay();
  }

  Future<void> _switchPageAfterDelay() async {
    await Future.delayed(Duration(seconds: 4));
    if (!(await _sendAnswers())) {
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        _tab = 2;
      });
    } else {
      setState(() {
        _tab++;
      });
    }
  }

  Character? character;

  Future<bool> _sendAnswers() async {
    try {
      character =
          await sendResponses(widget.output).timeout(Duration(seconds: 5));
      return character != null;
    } catch (e) {
      return false;
    }
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
            preferredSize: Size.fromHeight(1.0),
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
            actions: tabList[_tab].button),
      ),
    );
  }
}
