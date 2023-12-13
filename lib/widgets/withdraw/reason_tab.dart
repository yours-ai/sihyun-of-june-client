import 'package:flutter/material.dart';
import 'package:project_june_client/actions/auth/dtos.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/withdraw/withdraw_reason_widget.dart';

class ReasonTabWidget extends StatefulWidget {
  final void Function(QuitReasonDTO dto) onQuitResponse;
  final QuitReasonDTO dto;
  final TextEditingController reasonController;

  const ReasonTabWidget({
    super.key,
    required this.onQuitResponse,
    required this.dto,
    required this.reasonController,
  });

  @override
  State<ReasonTabWidget> createState() => _ReasonTabWidgetState();
}

class _ReasonTabWidgetState extends State<ReasonTabWidget> {
  final _formKey = GlobalKey<FormState>();

  void handleQuitResponse(String reasonKeyword) {
    setState(() {
      reasonKeyword == 'haveOtherReason'
          ? widget.dto.haveOtherReason = !widget.dto.haveOtherReason
          : widget.dto.reasons[reasonKeyword] =
              !widget.dto.reasons[reasonKeyword]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TitleLayout(
        withAppBar: true,
        title: Text(
          '탈퇴 사유를 알려주세요',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '탈퇴 사유를 알려주시면,\n더욱 개선된 서비스로 찾아뵙겠습니다.',
                    style: TextStyle(
                      height: 1.6,
                      fontSize: 14,
                      color: ColorConstants.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                WithDrawReasonWidget(
                  isChecked: widget.dto.reasons['dailyReplyBurden']!,
                  reasonKeyword: 'dailyReplyBurden',
                  reasonText: '매일 답장을 쓰는 것이 부담스러워요.',
                  onQuitResponse: handleQuitResponse,
                ),
                WithDrawReasonWidget(
                  isChecked: widget.dto.reasons['wantOtherCharacters']!,
                  reasonKeyword: 'wantOtherCharacters',
                  reasonText: '다른 캐릭터와도 대화를 하고싶어요.',
                  onQuitResponse: handleQuitResponse,
                ),
                WithDrawReasonWidget(
                  isChecked: widget.dto.reasons['notLikeHuman']!,
                  reasonKeyword: 'notLikeHuman',
                  reasonText: '사람과 대화하는 느낌이 들지 않아요.',
                  onQuitResponse: handleQuitResponse,
                ),
                WithDrawReasonWidget(
                  isChecked: widget.dto.reasons['toResetLetters']!,
                  reasonKeyword: 'toResetLetters',
                  reasonText: '편지를 초기화하고 다시 시작하고 싶어요.',
                  onQuitResponse: handleQuitResponse,
                ),
                WithDrawReasonWidget(
                  isChecked: widget.dto.reasons['manyErrors']!,
                  reasonKeyword: 'manyErrors',
                  reasonText: '오류가 많아요.',
                  onQuitResponse: handleQuitResponse,
                ),
                WithDrawReasonWidget(
                  isChecked: widget.dto.haveOtherReason,
                  reasonKeyword: 'haveOtherReason',
                  reasonText: '기타',
                  onQuitResponse: handleQuitResponse,
                ),
                widget.dto.haveOtherReason == true
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextFormField(
                          controller: widget.reasonController,
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
        ),
        actions: OutlinedButton(
          onPressed: () {
            if (widget.dto.haveOtherReason == true) {
              if (_formKey.currentState!.validate()) {
                widget.dto.otherReason = widget.reasonController.text;
                widget.onQuitResponse(widget.dto);
              }
              return;
            }
            if (widget.dto.isAllFalse && widget.dto.haveOtherReason == false) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('탈퇴 사유를 선택해주세요.'),
                ),
              );
              return;
            } else {
              widget.onQuitResponse(widget.dto);
            }
          },
          child: const Text('다음'),
        ),
      ),
    );
  }
}
