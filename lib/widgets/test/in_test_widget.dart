import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:project_june_client/actions/character/models/Question.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import '../../screens/test_screen.dart';

class InTestWidget extends StatefulWidget {
  const InTestWidget(
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

  int _currentQuestionIndex = 0;

  List<List<num>> answers = [];

  void addUserResponse(int question_id, int choice) {
    answers.add([question_id, choice]);
  }

  @override
  Widget build(BuildContext context) {
    return QueryBuilder(
      query: getQuestionsQuery(),
      builder: (context, state) {
        if (state.data == null) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        tabList = state.data;
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: AppBar(
              backgroundColor: ColorConstants.background,
              elevation: 0,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
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
              body: Container(),
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
      },
    );
  }
}
