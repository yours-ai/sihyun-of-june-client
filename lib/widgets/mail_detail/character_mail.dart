import 'package:flutter/cupertino.dart';

import '../../actions/mails/models/Mail.dart';
import '../../constants.dart';
import '../../services.dart';
import 'mail_info.dart';

class CharacterMailWidget extends StatelessWidget {
  final Mail mail;

  const CharacterMailWidget({Key? key, required this.mail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MailInfoWidget(
          byImage: mail.by_image,
          toFullName: mail.to_first_name,
          byFullName: mail.by_first_name,
          availableAt: mail.available_at,
          isMe: false,
        ),
        const SizedBox(
          height: 22,
        ),
        Text(
          mail.description,
          style: TextStyle(
            fontFamily: 'NanumNoRyeogHaNeunDongHee',
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: ColorConstants.primary,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}
