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
          toFullName: mail.to_full_name,
          byFullName: mail.by_full_name,
          availableAt: mail.available_at,
        ),
        const SizedBox(
          height: 22,
        ),
        Text(
          mail.description,
          style: TextStyle(
              fontFamily: 'MaruBuri',
              fontSize: 14,
              color: ColorConstants.primary),
        ),
      ],
    );
  }
}
