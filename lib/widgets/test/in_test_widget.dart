import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/actions.dart';
import 'package:project_june_client/actions/character/dtos.dart';
import 'package:project_june_client/actions/character/models/Question.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import '../../screens/test_screen.dart';

class InTestWidget extends StatefulWidget {
  const InTestWidget(
      {super.key, required this.onActiveScreen, required this.responses});

  final Function(ActiveScreen) onActiveScreen;
  final Function(AnswerDTOList) responses;

  @override
  State<StatefulWidget> createState() {
    return _InTestWidget();
  }
}

class _InTestWidget extends State<InTestWidget> {
  List<Question>? questionList;
  Mutation<List<Question>, void>? mutation;

  int _currentQuestionIndex = 0;

  AnswerDTOList answerList = AnswerDTOList(answers: []);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        mutation = getStartTestMutation(
          onError: (arg, err, fallback) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("캐릭터 배정을 시작할 수 없어요. 에러가 계속되면 고객센터에 문의해주세요."),
              ),
            );
            logout();
            context.go('/');
          },
        );
      });
      mutation!.mutate();
    });
  }

  void addUserResponse(int question_id, int choice) {
    setState(() {
      answerList.addAnswer(AnswerDTO(
        question_id: question_id,
        choice: choice,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return mutation != null
        ? MutationBuilder(
            mutation: mutation!,
            builder: (context, state, mutate) {
              if (state.data == null) {
                return const Scaffold(
                    body: Center(child: CircularProgressIndicator()));
              }
              questionList = state.data;
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
                        valueColor: AlwaysStoppedAnimation<Color>(
                            ColorConstants.lightPink),
                      ),
                    ),
                  ),
                ),
                body: SafeArea(
                  child: TitleLayout(
                    titleText:
                        questionList![_currentQuestionIndex].question_text,
                    body: Container(),
                    actions: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            addUserResponse(
                                questionList![_currentQuestionIndex].id.toInt(),
                                1);
                            if (_currentQuestionIndex ==
                                questionList!.length - 1) {
                              widget.onActiveScreen(ActiveScreen.result);
                              widget.responses(answerList);
                            } else
                              setState(() {
                                _currentQuestionIndex++;
                              });
                          },
                          child: Text(questionList![_currentQuestionIndex]
                              .choice_1_text),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            addUserResponse(
                                questionList![_currentQuestionIndex].id.toInt(),
                                2);
                            if (_currentQuestionIndex ==
                                questionList!.length - 1) {
                              widget.onActiveScreen(ActiveScreen.result);
                              widget.responses(answerList);
                            } else {
                              setState(() {
                                _currentQuestionIndex++;
                              });
                            }
                          },
                          child: Text(questionList![_currentQuestionIndex]
                              .choice_2_text),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : const SizedBox.shrink();
  }
}
