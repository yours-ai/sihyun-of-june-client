import 'dart:async';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:project_june_client/actions/character/dtos.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';

class TestResultData {
  final String titleText;
  final Widget body;
  final String button;

  const TestResultData({
    required this.titleText,
    this.body = const SizedBox(),
    required this.button,
  });
}

final List<TestResultData> tabList = [
  TestResultData(
    titleText: '테스트가 완료됐어요!\n상대를 정하는 중이에요...',
    body: Lottie.asset('assets/lotties/waitingResultLottie.json'),
    button: '두근두근...',
  ),
  const TestResultData(
    titleText: '상대가 정해졌어요!\n확인해보시겠어요?',
    button: '확인해보기',
  ),
  const TestResultData(
    titleText: '오류가 발생했어요',
    button: '다시 하기',
  ),
];

class TestResultWidget extends StatefulWidget {
  final AnswerDTOList responses;

  const TestResultWidget({super.key, required this.responses});

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
    });
  }

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
      body: SafeArea(
        child: TitleLayout(
          title: Text(
            tabList[_tab].titleText,
            style: Theme.of(context).textTheme.titleLarge,
            softWrap: true,
            textAlign: TextAlign.center,
          ),
          body: Builder(
            builder: (context) {
              return Center(
                child: AnimatedCrossFade(
                  firstChild: tabList[0].body,
                  secondChild: tabList[1].body,
                  crossFadeState: _tab == 0
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 500),
                ),
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
                      mutation: getSendResponseMutation(
                        onSuccess: (res, arg) {
                          context.go('/character-choice');
                        },
                        onError: (arg, error, callback) {
                          setState(() {
                            _tab = 2;
                          });
                        },
                      ),
                      builder: (context, state, mutate) => FilledButton(
                          onPressed: () =>
                              {mutate(widget.responses.toJsonList())},
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
