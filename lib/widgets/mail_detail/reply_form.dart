import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/widgets/mail_detail/mail_info.dart';
import 'package:project_june_client/widgets/modal_widget.dart';

import '../../actions/mails/dtos.dart';
import '../../actions/mails/models/Mail.dart';
import '../../actions/mails/queries.dart';
import '../../constants.dart';
import '../../services.dart';

class ReplyFormWidget extends StatefulWidget {
  final Mail mail;

  const ReplyFormWidget({Key? key, required this.mail}) : super(key: key);

  @override
  State<ReplyFormWidget> createState() => _ReplyFormWidgetState();
}

class _ReplyFormWidgetState extends State<ReplyFormWidget> {
  final controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  ReplyMailDTO getReplyDTO() {
    return ReplyMailDTO(
      id: widget.mail.id,
      description: controller.value.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mutation = getSendMailReplyMutation(
      refetchQueries: ['character-sent-mail/${widget.mail.id}'],
      onSuccess: (res, arg) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('답장을 보냈습니다.'),
          ),
        );
      },
    );
    _showConfirmModal() async {
      await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ModalWidget(
            title: '답장을 모두 작성하셨나요?',
            description: Padding(
              padding: const EdgeInsets.only(top:20),
              child: Text('답장을 보내면 수정이 불가능해요.🥲'),
            ),
            choiceColumn: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FilledButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ColorConstants.background),
                  ),
                  onPressed: () {
                    context.pop();
                  },
                  child: Text(
                    '아니요',
                    style: TextStyle(
                        fontSize: 14.0, color: ColorConstants.secondary),
                  ),
                ),
                MutationBuilder(
                  mutation: mutation,
                  builder: (context, state, mutate) => FilledButton(
                    onPressed: () => mutate(getReplyDTO()),
                    child: const Text(
                      '네',
                      style: TextStyle(
                        fontFamily: 'MaruBuri',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    final mailDueTimeLabel =
        mailService.getMailDueTimeLabel(widget.mail.available_at);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MailInfoWidget(
          byFullName: widget.mail.to_full_name,
          toFullName: widget.mail.by_full_name,
          availableAt: clock.now(),
        ),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '답장을 입력해주세요.';
                  }
                  return null;
                },
                controller: controller,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                minLines: 8,
                maxLength: 1000,
                decoration: InputDecoration(
                  errorText: '',
                  counterText: controller.text.length > 900
                      ? '${controller.text.length}/1000'
                      : '',
                  errorStyle: TextStyle(
                    color: ColorConstants.black,
                  ),
                  hintText: '답장을 적어주세요...',
                  hintStyle: TextStyle(
                      fontFamily: 'MaruBuri',
                      fontSize: 14,
                      color: ColorConstants.primary),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontFamily: 'MaruBuri',
                  fontSize: 14,
                  color: ColorConstants.primary,
                  height: 1.5,
                ),
                onChanged: (text) {
                  setState(() {});
                },
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _showConfirmModal();
                    }
                  },
                  child: const Text(
                    '답장하기',
                    style: TextStyle(
                      fontFamily: 'MaruBuri',
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                  child: Text(
                mailDueTimeLabel,
                style: TextStyle(
                  fontSize: 12,
                  color: ColorConstants.secondary,
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }
}
