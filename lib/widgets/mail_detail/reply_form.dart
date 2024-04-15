import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/mails/models/MailInDetail.dart';
import 'package:project_june_client/router.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/mail_detail/mail_info.dart';
import 'package:project_june_client/widgets/common/modal/modal_choice_widget.dart';
import 'package:project_june_client/widgets/common/modal/modal_description_widget.dart';
import 'package:project_june_client/widgets/common/modal/modal_widget.dart';
import 'package:project_june_client/widgets/mail_detail/replied.dart';

import '../../actions/mails/dtos.dart';
import '../../actions/mails/queries.dart';
import '../../constants.dart';

class ReplyFormWidget extends ConsumerStatefulWidget {
  final MailInDetail mail;
  final int primaryColorInMail;
  final String characterName;
  final int characterId;
  final FocusNode focusNode;
  final GlobalKey<FormState> formKey;

  const ReplyFormWidget({
    Key? key,
    required this.characterId,
    required this.mail,
    required this.primaryColorInMail,
    required this.characterName,
    required this.focusNode,
    required this.formKey,
  }) : super(key: key);

  @override
  ReplyFormWidgetState createState() => ReplyFormWidgetState();
}

class ReplyFormWidgetState extends ConsumerState<ReplyFormWidget> {
  final controller = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    mailService.getBeforeReply(controller: controller, mailId: widget.mail.id);
  }

  @override
  void dispose() async {
    super.dispose();
    await mailService.saveBeforeReply(
      reply: controller.value.text,
      mailId: widget.mail.id,
    );
    controller.dispose();
  }

  ReplyMailDTO getReplyDTO() {
    return ReplyMailDTO(
      id: widget.mail.id,
      description: controller.value.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mutation = replyMailMutation(
      refetchQueries: [
        'character-sent-mail/${widget.mail.id}',
      ],
      onSuccess: (res, arg) {
        mailService.deleteBeforeReply(widget.mail.id);
      },
    );
    showConfirmModal() async {
      await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return MutationBuilder(
            mutation: mutation,
            builder: (context, state, mutate) => PopScope(
              canPop: !isLoading,
              child: ModalWidget(
                title: '정말 이대로 보내시겠어요?',
                description: const ModalDescriptionWidget(
                    description: '답장을 보내면 수정이 불가능해요.🥲'),
                choiceColumn: ModalChoiceWidget(
                  submitText: '네',
                  onSubmit: () async {
                    if (!isLoading) {
                      setState(() {
                        isLoading = true;
                      });
                      mutate(getReplyDTO()).then((_) {
                        router.pop();
                        fetchMailListQuery(assignId: widget.mail.assign)
                            .refetch();
                        mailService.requestRandomlyAppReview();
                        setState(() {
                          isLoading = false;
                        });
                      });
                    } else {
                      await Future.delayed(const Duration(seconds: 5));
                    }
                  },
                  cancelText: '아니요',
                  onCancel: () async {
                    if (!isLoading) {
                      context.pop();
                    } else {
                      await Future.delayed(const Duration(seconds: 5));
                    }
                  },
                ),
              ),
            ),
          );
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MailInfoWidget(
          byFullName: widget.mail.to_first_name,
          toFullName: widget.characterName,
          byImage: widget.mail.to_image,
          isMe: true,
          availableAt: clock.now(),
          primaryColorInMail: widget.primaryColorInMail,
        ),
        Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                focusNode: widget.focusNode,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '답장을 입력해주세요.';
                  }
                  return null;
                },
                onChanged: (value) {
                  mailService.saveBeforeReply(
                    reply: value,
                    mailId: widget.mail.id,
                  );
                },
                controller: controller,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                minLines: 8,
                maxLength: 1000,
                decoration: InputDecoration(
                  helperText: '',
                  counterText: controller.text.length > 900
                      ? '${controller.text.length}/1000'
                      : '',
                  hintText: '답장을 입력해주세요...',
                  hintStyle:
                      userMailFontStyle.copyWith(color: ColorConstants.neutral),
                  border: InputBorder.none,
                ),
                style: userMailFontStyle,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ColorConstants.gray),
                  ),
                  onPressed: () {
                    if (widget.formKey.currentState!.validate()) {
                      showConfirmModal();
                    }
                  },
                  child: const Text(
                    '답장 보내기',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}
