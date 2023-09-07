import 'package:flutter/material.dart';
import 'package:project_june_client/actions/character/actions.dart';
import 'package:project_june_client/actions/character/models/Question.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import '../../screens/test_screen.dart';

class InTestWidget extends StatefulWidget {
  InTestWidget(
      {super.key, required this.setActiveScreen, required this.responses});

  final Function(ActiveScreen) setActiveScreen;
  final Function(List<List<num>>) responses;

  @override
  State<StatefulWidget> createState() {
    return _InTestWidget();
  }
}

class _InTestWidget extends State<InTestWidget> {
  List<Question>? tabList;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    tabList = await fetchQuestions();
    setState(() {});
  }

  int _currentQuestionIndex = 0;
  final PageController _controller = PageController();

  void _nextQuestion(int index) {
    setState(() {
      _currentQuestionIndex = index;
    });
  }

  List<List<num>> answers = [];

  void addUserResponse(int question_id, int choice) {
    answers.add([question_id, choice]);
  }

  @override
  Widget build(BuildContext context) {
    if (tabList == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: AppBar(
          backgroundColor: ColorConstants.background,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / 8,
              backgroundColor: ColorConstants.background,
              valueColor:
                  AlwaysStoppedAnimation<Color>(ColorConstants.secondary),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: TitleLayout(
          titleText: tabList![_currentQuestionIndex].question_text,
          body: Builder(builder: (context) {
            final double height = MediaQuery.of(context).size.height;
            return PageView(
              controller: _controller,
              onPageChanged: (index) {
                _nextQuestion(index);
              },
            );
          }),
          actions: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OutlinedButton(
                onPressed: () {
                  addUserResponse(
                      tabList![_currentQuestionIndex].id.toInt(), 1);
                  if (_currentQuestionIndex == 7) {
                    widget.setActiveScreen(ActiveScreen.result);
                    widget.responses(answers);
                  } else
                    setState(() {
                      _currentQuestionIndex++;
                    });
                },
                child: Text(tabList![_currentQuestionIndex].choice_1_text),
              ),
              const SizedBox(
                height: 15,
              ),
              OutlinedButton(
                onPressed: () {
                  addUserResponse(
                      tabList![_currentQuestionIndex].id.toInt(), 2);
                  if (_currentQuestionIndex == 7) {
                    widget.setActiveScreen(ActiveScreen.result);
                    widget.responses(answers);
                    print(answers);
                  } else
                    setState(() {
                      _currentQuestionIndex++;
                    });
                },
                child: Text(tabList![_currentQuestionIndex].choice_2_text),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
