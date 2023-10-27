import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:project_june_client/actions/auth/dtos.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/withdraw/withdraw_reason_widget.dart';

class ReasonTabWidget extends StatefulWidget {
  final void Function() onQuitResponse;

  const ReasonTabWidget({super.key, required this.onQuitResponse});

  @override
  State<ReasonTabWidget> createState() => _ReasonTabWidgetState();
}

class _ReasonTabWidgetState extends State<ReasonTabWidget> {
  final _formKey = GlobalKey<FormState>();
  final reasonController = TextEditingController();
  QuitReasonDTO dto = QuitReasonDTO();
  bool haveOtherReason = false;
  String? otherReason;

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  void handleQuitResponse(String reasonKeyword) {
    if (reasonKeyword == 'haveOtherReason') {
      setState(() {
        haveOtherReason = !haveOtherReason;
      });
      return;
    }
    setState(() {
      dto.reasons[reasonKeyword] = !dto.reasons[reasonKeyword]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MutationBuilder(
      mutation: sendQuitResponseMutation(
        onSuccess: (res, arg) {
          widget.onQuitResponse();
        },
      ),
      builder: (context, state, mutate) => Form(
        key: _formKey,
        child: TitleLayout(
          titleText: '탈퇴 사유를 알려주세요',
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '탈퇴 사유를 알려주시면,\n더욱 개선된 서비스로 찾아뵙겠습니다.',
                    style: TextStyle(
                      height: 1.6,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                WithDrawReasonWidget(
                  reasonKeyword: 'dailyReplyBurden',
                  reasonText: '매일 답장을 쓰는 것이 부담스러워요.',
                  onQuitResponse: handleQuitResponse,
                ),
                WithDrawReasonWidget(
                  reasonKeyword: 'wantOtherCharacters',
                  reasonText: '다른 캐릭터와도 대화를 하고싶어요.',
                  onQuitResponse: handleQuitResponse,
                ),
                WithDrawReasonWidget(
                  reasonKeyword: 'notLikeHuman',
                  reasonText: '사람과 대화하는 느낌이 들지 않아요.',
                  onQuitResponse: handleQuitResponse,
                ),
                WithDrawReasonWidget(
                  reasonKeyword: 'toResetLetters',
                  reasonText: '편지를 초기화하고 다시 시작하고 싶어요.',
                  onQuitResponse: handleQuitResponse,
                ),
                WithDrawReasonWidget(
                  reasonKeyword: 'manyErrors',
                  reasonText: '오류가 많아요.',
                  onQuitResponse: handleQuitResponse,
                ),
                WithDrawReasonWidget(
                  reasonKeyword: 'haveOtherReason',
                  reasonText: '기타',
                  onQuitResponse: handleQuitResponse,
                ),
                haveOtherReason == true
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextFormField(
                          controller: reasonController,
                          decoration: const InputDecoration(
                            hintText: '탈퇴 사유를 입력해주세요.',
                            border: InputBorder.none,
                          ),
                          minLines: 1,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '탈퇴 사유를 입력해주세요.';
                            }
                            return null;
                          },
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          actions: OutlinedButton(
            onPressed: () {
              if (haveOtherReason == true) {
                if (_formKey.currentState!.validate()) {
                  dto.otherReason = reasonController.text;
                  mutate(dto);
                }
                return;
              }
              if (dto.isAllFalse && haveOtherReason == false) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('탈퇴 사유를 선택해주세요.'),
                  ),
                );
                return;
              } else {
                mutate(dto);
              }
            },
            child: const Text('탈퇴하기'),
          ),
        ),
      ),
    );
  }
}
