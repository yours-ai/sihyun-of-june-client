import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/mails/models/reply.dart';
import 'package:project_june_client/widgets/mail_detail/character_mail.dart';

import 'mail_info.dart';

class RepliedWidget extends ConsumerWidget {
  final String characterName;
  final String userName;
  final Reply reply;
  final String? toImage;
  final int primaryColorInMail;

  const RepliedWidget({
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
          style: userMailFontStyle,
        ),
        const SizedBox(
          height: 80,
        ),
      ],
    );
  }
}

const userMailFontStyle = TextStyle(
  fontFamily: 'NanumDaCaeSaRang',
  fontSize: 20,
  fontWeight: FontWeight.normal,
  color: characterFontColor,
  height: 1.46,
  letterSpacing: 1.1,
  wordSpacing: -1.8,
);
