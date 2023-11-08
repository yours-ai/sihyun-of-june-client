import 'package:flutter/cupertino.dart';
import 'package:project_june_client/actions/mails/models/Reply.dart';

import '../../constants.dart';
import 'mail_info.dart';

class ReplyWidget extends StatelessWidget {
  final String toFullName;
  final String byFullName;
  final Reply reply;
  final String? toImage;

  const ReplyWidget({
    Key? key,
    required this.reply,
    required this.toFullName,
    required this.byFullName,
    required this.toImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MailInfoWidget(
          byFullName: byFullName,
          toFullName: toFullName,
          availableAt: reply.created,
          byImage: toImage,
          isMe: true,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          reply.description,
          style: TextStyle(
            fontFamily: 'NanumDaCaeSaRang',
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: ColorConstants.primary,
          ),
        ),
      ],
    );
  }
}
