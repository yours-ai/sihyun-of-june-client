import 'package:flutter/cupertino.dart';
import 'package:project_june_client/actions/mails/models/Reply.dart';

import '../../constants.dart';
import 'mail_info.dart';

class ReplyWidget extends StatelessWidget {
  final String toFullName;
  final String byFullName;
  final Reply reply;

  const ReplyWidget({
    Key? key,
    required this.reply,
    required this.toFullName,
    required this.byFullName,
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
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          reply.description,
          style: TextStyle(
            fontFamily: 'MaruBuri',
            fontSize: 14,
            color: ColorConstants.primary,
          ),
        ),
      ],
    );
  }
}
