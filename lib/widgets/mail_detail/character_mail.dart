import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/character/models/CharacterTheme.dart';
import 'package:project_june_client/providers/character_provider.dart';

import '../../actions/mails/models/Mail.dart';
import '../../constants.dart';
import 'mail_info.dart';

class CharacterMailWidget extends ConsumerWidget {
  final Mail mail;
  final CharacterTheme characterThemeInMail;

  const CharacterMailWidget(
      {Key? key, required this.mail, required this.characterThemeInMail})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MailInfoWidget(
          byImage: mail.by_image,
          toFullName: mail.to_first_name,
          byFullName: mail.by_first_name,
          availableAt: mail.available_at,
          isMe: false,
          primaryColorInMail: characterThemeInMail.colors!.primary!,
        ),
        const SizedBox(
          height: 22,
        ),
        Text(
          mail.description,
          style: TextStyle(
            fontFamily: characterThemeInMail.font,
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: ColorConstants.primary,
            height: 1.289,
            letterSpacing: 1.02,
          ),
        ),
      ],
    );
  }
}
