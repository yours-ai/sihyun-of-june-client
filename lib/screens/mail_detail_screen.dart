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

class MailDetailScreen extends StatefulWidget {
  final int id;

  const MailDetailScreen({super.key, required this.id});

  @override
  State<MailDetailScreen> createState() => _MailDetailScreenState();
}

class _MailDetailScreenState extends State<MailDetailScreen> {
  Mutation<void, int>? mutation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        mutation = getReadMailMutation(
          refetchQueries: ['character-sent-mail-list'],
          onError: (arr, err, fallback) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('메일을 읽지 못했습니다. 에러가 계속되면 고객센터에 문의해주세요.'),
              ),
            );
          },
        );
        mutation!.mutate(widget.id);
      });
    });
  }

  @override
  Widget build(context) {
    final query = getRetrieveMailQuery(
      id: widget.id,
    );

    if (mutation == null) {
      return SizedBox.shrink();
    }

    return MutationBuilder(
      mutation: mutation!,
      builder: (context, state, mutate) {
        return state.status == QueryStatus.success
            ? (QueryBuilder(
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
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 30),
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
                                    mailService
                                        .isMailReplyable(mailState.data!)) ...[
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 30),
                                    height: 1,
                                    color: ColorConstants.light,
                                  ),
                                  ReplyFormWidget(
                                    mail: mailState.data!,
                                  )
                                ],
                                if (mailState.data!.replies!.isEmpty &&
                                    !mailService
                                        .isMailReplyable(mailState.data!)) ...[
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 30, bottom: 45),
                                    height: 1,
                                    color: ColorConstants.light,
                                  ),
                                  Center(
                                    child: Text(
                                      '답장 가능 시간이 지났어요.🥲\n답장은 오전 9시까지만 가능해요.',
                                      style: TextStyle(
                                        height: 1.5,
                                        fontSize: 14,
                                        color: ColorConstants.neutral,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ))
            : (const SizedBox());
      },
    );
  }
}
