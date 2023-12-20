import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/widgets/common/back_appbar.dart';
import 'package:project_june_client/widgets/common/dotted_underline.dart';
import 'package:project_june_client/widgets/mail_detail/character_mail.dart';
import 'package:project_june_client/widgets/mail_detail/reply.dart';
import 'package:project_june_client/widgets/mail_detail/reply_form.dart';

import '../../actions/mails/queries.dart';

class MailDetailScreen extends StatefulWidget {
  final int id;
  final int? selectedPage;

  const MailDetailScreen({super.key, required this.id, this.selectedPage});

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
      return const SizedBox.shrink();
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
                  return QueryBuilder(
                    query: getCharacterQuery(id: mailState.data!.by),
                    builder: (context, state) {
                      if (state.data == null) {
                        return const SizedBox.shrink();
                      }
                      final characterInMail = state.data!;
                      return GestureDetector(
                        onTap: () =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        child: Scaffold(
                          appBar: const BackAppbar(),
                          body: SafeArea(
                            child: SingleChildScrollView(
                              reverse:
                                  MediaQuery.of(context).viewInsets.bottom > 0
                                      ? true
                                      : false,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 36.0,
                                  vertical: 10.0,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CharacterMailWidget(
                                      mail: mailState.data!,
                                      characterInMail: characterInMail,
                                    ),
                                    if (mailState
                                        .data!.replies!.isNotEmpty) ...[
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 30),
                                        height: 1,
                                        color: ColorConstants.lightGray,
                                        child: const DottedUnderline(0),
                                      ),
                                      ReplyWidget(
                                        reply: mailState.data!.replies!.first,
                                        userName: mailState.data!.to_first_name,
                                        characterName:
                                            characterInMail.first_name!,
                                        toImage: mailState.data!.to_image,
                                        primaryColorInMail: characterInMail
                                            .theme!.colors!.primary!,
                                      )
                                    ],
                                    if (mailState.data!.replies!.isEmpty &&
                                        mailState.data!.is_latest) ...[
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 30),
                                        height: 1,
                                        color: ColorConstants.lightGray,
                                        child: const DottedUnderline(0),
                                      ),
                                      ReplyFormWidget(
                                        mail: mailState.data!,
                                        primaryColorInMail: characterInMail
                                            .theme!.colors!.primary!,
                                        characterName:
                                            characterInMail.first_name!,
                                        characterId: characterInMail.id,
                                        selectedPage: widget.selectedPage,
                                      )
                                    ],
                                    if (mailState.data!.replies!.isEmpty &&
                                        !mailState.data!.is_latest) ...[
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 30, bottom: 45),
                                        height: 1,
                                        color: ColorConstants.lightGray,
                                        child: const DottedUnderline(0),
                                      ),
                                      Center(
                                        child: Text(
                                          '답장 가능한 시간이 지났어요.🥲\n최근 편지에만 답장이 가능해요.',
                                          style: TextStyle(
                                            height: 1.5,
                                            fontSize: 16,
                                            color: ColorConstants.neutral,
                                            fontWeight:
                                                FontWeightConstants.semiBold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(height: 40),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ))
            : (const SizedBox());
      },
    );
  }
}
