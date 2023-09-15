import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/mail_detail/character_mail.dart';
import 'package:project_june_client/widgets/mail_detail/reply.dart';
import 'package:project_june_client/widgets/mail_detail/reply_form.dart';

import '../actions/mails/queries.dart';

class MailDetailScreen extends StatelessWidget {
  final int id;

  const MailDetailScreen({super.key, required this.id});

  @override
  Widget build(context) {
    final query = getRetrieveMailQuery(
      id: id,
    );
    return QueryBuilder(
      query: query,
      builder: (context, mailState) {
        if (mailState.data == null) {
          return const Scaffold();
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorConstants.background,
            elevation: 0,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: Container(
                padding: const EdgeInsets.only(left: 23),
                child: Icon(
                  PhosphorIcons.arrow_left,
                  color: ColorConstants.black,
                  size: 32,
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CharacterMailWidget(mail: mailState.data!),
                      if (mailState.data!.replies!.isNotEmpty) ...[
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 30),
                          height: 1,
                          color: ColorConstants.light,
                        ),
                        ReplyWidget(
                          reply: mailState.data!.replies!.first,
                          toFullName: mailState.data!.by_full_name,
                          byFullName: mailState.data!.to_full_name,
                        )
                      ],
                      if (mailState.data!.replies!.isEmpty &&
                          mailService.isMailReplyable(mailState.data!)) ...[
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 30),
                          height: 1,
                          color: ColorConstants.light,
                        ),
                        ReplyFormWidget(
                          mail: mailState.data!,
                        )
                      ]
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
