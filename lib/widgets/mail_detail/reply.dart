import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/mails/models/Reply.dart';

import '../../constants.dart';
import 'mail_info.dart';

class ReplyWidget extends ConsumerWidget {
  final String characterName;
  final String userName;
  final Reply reply;
  final String? toImage;
  final int primaryColorInMail;

  const ReplyWidget({
    Key? key,
    required this.reply,
    required this.characterName,
    required this.userName,
    required this.toImage,
    required this.primaryColorInMail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MailInfoWidget(
          byFullName: userName,
          toFullName: characterName,
          availableAt: reply.created,
          byImage: toImage,
          isMe: true,
          primaryColorInMail: primaryColorInMail,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          reply.description,
          style: TextStyle(
            fontFamily: 'NanumDaCaeSaRang',
            fontSize: 19,
            fontWeight: FontWeightConstants.semiBold,
            color: ColorConstants.primary,
            height: 1.289,
            letterSpacing: 1.02,
          ),
        ),
      ],
    );
  }
}
