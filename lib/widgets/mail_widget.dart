import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/mails/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/services.dart';

import '../actions/mails/models/Mail.dart';

class MailWidget extends StatelessWidget {
  final Mail? mail;
  final int? mailNumber;
  final DateTime? firstMailDate;

  MailWidget({super.key, this.mail, this.mailNumber = 0, this.firstMailDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: mail != null
          ? GestureDetector(
              onTap: () {
                context.push('/mails/detail/${mail!.id}');
              },
              child: Column(
                children: [
                  mail!.replies!.isEmpty
                      ? Image.asset('assets/images/mail/mailNotReplied.png',
                          width: 35)
                      : Image.asset('assets/images/mail/mailReplied.png',
                          width: 35),
                  SizedBox(height: 1),
                  Text(
                    mailService.getMailReceiveTimeStr(
                        mail!.available_at, mailNumber == 0),
                    style: TextStyle(fontSize: 11, fontFamily: 'GowunDodum'),
                  )
                ],
              ),
            )
          : Column(
              children: [
                Image.asset('assets/images/mail/mailNotSent.png', width: 35),
                SizedBox(height: 1),
                Text(
                  mailService.getMailReceiveTimeStr(
                      firstMailDate!.add(Duration(days: mailNumber!)),
                      mailNumber == 0),
                  style: TextStyle(fontSize: 11, fontFamily: 'GowunDodum'),
                ),
              ],
            ),
    );
  }
}
