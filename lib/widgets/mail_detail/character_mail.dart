import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/services.dart';

import '../../actions/mails/models/Mail.dart';
import '../../constants.dart';
import 'mail_info.dart';

class CharacterMailWidget extends ConsumerWidget {
  final Mail mail;
  final Character characterInMail;

  const CharacterMailWidget(
      {Key? key, required this.mail, required this.characterInMail})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainImage = characterService.getMainImage(characterInMail.character_info!.images!).src;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MailInfoWidget(
          byImage: mainImage,
          toFullName: mail.to_first_name,
          byFullName: characterInMail.first_name!,
          availableAt: mail.available_at,
          isMe: false,
          primaryColorInMail: characterInMail.theme!.colors!.primary!,
        ),
        const SizedBox(
          height: 22,
        ),
        Text(
          mail.description,
          style: TextStyle(
            fontFamily: characterInMail.theme!.font,
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
