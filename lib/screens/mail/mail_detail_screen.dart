import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/services.dart';
import 'package:project_june_client/widgets/common/back_appbar.dart';
import 'package:project_june_client/widgets/common/dotted_underline.dart';
import 'package:project_june_client/widgets/mail_detail/character_mail.dart';
import 'package:project_june_client/widgets/mail_detail/replied.dart';
import 'package:project_june_client/widgets/mail_detail/reply_form.dart';

import '../../actions/mails/queries.dart';

enum UserStateInMail {
  canReply,
  replied,
  cannotReplyCurrentMonth,
  cannotReplyPastMonth,
}

class MailDetailScreen extends StatefulWidget {
  final int id;

  const MailDetailScreen({super.key, required this.id});

  @override
  State<MailDetailScreen> createState() => _MailDetailScreenState();
}

class _MailDetailScreenState extends State<MailDetailScreen> {
  Mutation<void, int>? mutation;
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_scrollToFocusedField);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        mutation = readMailMutation(
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
  void dispose() {
    _focusNode.removeListener(_scrollToFocusedField);
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToFocusedField() {
    if (_focusNode.hasFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final RenderBox? fieldBox =
            _formKey.currentContext?.findRenderObject() as RenderBox?;
        if (fieldBox == null) return;
        const textFormSpaceHeight = 150;
        bool isAtBottom = _scrollController.offset >=
            _scrollController.position.maxScrollExtent - textFormSpaceHeight;
        if (isAtBottom) return;
        final targetScrollPosition =
            _scrollController.position.maxScrollExtent +
                fieldBox.size.height -
                textFormSpaceHeight;
        _scrollController.animateTo(
          targetScrollPosition,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(context) {
    final query = fetchMailByIdQuery(
      id: widget.id,
    );
    if (mutation == null) {
      return const SizedBox.shrink();
    }
    return QueryBuilder(
      query: query,
      builder: (context, mailState) {
        if (mailState.data == null) {
          return const Scaffold();
        }
        return QueryBuilder(
          query: fetchMyCharacterQuery(),
          builder: (context, characterState) {
            if (characterState.data == null) {
              return const SizedBox.shrink();
            }
            final Character characterInMail = characterState.data!
                .firstWhere((character) => character.id == mailState.data!.by);
            final UserStateInMail userStateInMail =
                mailService.checkUserStateInMail(
              mailState.data!,
              characterInMail,
            );
            return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: const BackAppbar(),
              body: SafeArea(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 36.0,
                      vertical: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: _focusNode.unfocus,
                          child: CharacterMailWidget(
                            mail: mailState.data!,
                            characterInMail: characterInMail,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 30),
                          height: 1,
                          color: ColorConstants.veryLightGray,
                          child: const DottedUnderline(0),
                        ),
                        if (userStateInMail == UserStateInMail.replied) ...[
                          RepliedWidget(
                            reply: mailState.data!.replies!.first,
                            userName: mailState.data!.to_first_name,
                            characterName: characterInMail.first_name,
                            toImage: mailState.data!.to_image,
                            primaryColorInMail:
                                characterInMail.theme.colors.primary,
                          )
                        ],
                        if (userStateInMail == UserStateInMail.canReply) ...[
                          ReplyFormWidget(
                            mail: mailState.data!,
                            primaryColorInMail:
                                characterInMail.theme.colors.primary,
                            characterName: characterInMail.first_name,
                            characterId: characterInMail.id,
                            focusNode: _focusNode,
                            formKey: _formKey,
                          )
                        ],
                        if (userStateInMail ==
                            UserStateInMail.cannotReplyCurrentMonth) ...[
                          Center(
                            child: Text(
                              '답장 가능한 시간이 지났어요.🥲\n최근 편지에만 답장이 가능해요.',
                              style: TextStyle(
                                height: 1.5,
                                fontSize: 16,
                                color: ColorConstants.neutral,
                                fontWeight: FontWeightConstants.semiBold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 40),
                        ],
                        if (userStateInMail ==
                            UserStateInMail.cannotReplyPastMonth) ...[
                          Center(
                            child: Text(
                              '지난 달에는 답장이 불가능해요 🥲\n이번 달 편지에만 답장이 가능해요.',
                              style: TextStyle(
                                height: 1.5,
                                fontSize: 16,
                                color: ColorConstants.neutral,
                                fontWeight: FontWeightConstants.semiBold,
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
            );
          },
        );
      },
    );
  }
}
