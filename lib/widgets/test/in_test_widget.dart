import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/actions.dart';
import 'package:project_june_client/actions/character/dtos.dart';
import 'package:project_june_client/actions/character/models/Question.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:word_break_text/word_break_text.dart';
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
                appBar: AppBar(
                  backgroundColor: ColorConstants.background,
                  elevation: 0,
                  title: Center(
                    child: Text(
                      '${_currentQuestionIndex + 1}/${questionList!.length}',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 20,
                        color: ColorConstants.neutral,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                body: SafeArea(
                  child: TitleLayout(
                    withAppBar: true,
                    title: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1),
                      child: WordBreakText(
                        questionList![_currentQuestionIndex].question_text,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: ColorConstants.primary),
                        textAlign: TextAlign.center,
                        spacingByWrap: true,
                        spacing: 10,
                        wrapAlignment: WrapAlignment.center,
                      ),
                    ),
                    body: const SizedBox(),
                    actions: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        FilledButton(
                          style: Theme.of(context)
                              .filledButtonTheme
                              .style!
                              .copyWith(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        ColorConstants.gray),
                              ),
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
                        FilledButton(
                          style: Theme.of(context)
                              .filledButtonTheme
                              .style!
                              .copyWith(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        ColorConstants.gray),
                              ),
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
