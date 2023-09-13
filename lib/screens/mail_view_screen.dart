import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/mails/dtos.dart';
import 'package:project_june_client/constants.dart';

import '../actions/mails/queries.dart';

class MailViewScreen extends StatefulWidget {
  final int? id;

  MailViewScreen({super.key, required this.id});

  @override
  State<MailViewScreen> createState() => _MailViewScreenState();
}

class _MailViewScreenState extends State<MailViewScreen> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  ReplyMailDTO getReplyDTO() {
    return ReplyMailDTO(
      id: widget.id ?? 0,
      description: controller.value.text,
    );
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(context) {
    return QueryBuilder(
      query: getMailQuery(id: widget.id ?? 0),
      builder: (context, state) {
        if (state.data == null) {
          return const Scaffold();
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorConstants.background,
            elevation: 0,
            leading: IconButton(
              onPressed: () => context.go('/mails'),
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
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              state.data!.by_image!,
                              height: 46,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'From.',
                                          style: TextStyle(
                                              fontFamily: 'MaruBuri',
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: ColorConstants.primary),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          state.data!.by_full_name,
                                          style: TextStyle(
                                              fontFamily: 'MaruBuri',
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: ColorConstants.primary),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      state.data!.available_at.substring(0, 10),
                                      style: TextStyle(
                                          fontFamily: 'MaruBuri',
                                          fontSize: 12,
                                          color: ColorConstants.primary),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'To.',
                                      style: TextStyle(
                                          fontFamily: 'MaruBuri',
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: ColorConstants.primary),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      state.data!.to_full_name,
                                      style: TextStyle(
                                          fontFamily: 'MaruBuri',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: ColorConstants.primary),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Text(
                        state.data!.description,
                        style: TextStyle(
                            fontFamily: 'MaruBuri',
                            fontSize: 14,
                            color: ColorConstants.primary),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 30),
                        height: 1,
                        color: ColorConstants.light,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'From.',
                                    style: TextStyle(
                                        fontFamily: 'MaruBuri',
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        color: ColorConstants.primary),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    state.data!.to_full_name,
                                    style: TextStyle(
                                        fontFamily: 'MaruBuri',
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: ColorConstants.primary),
                                  ),
                                ],
                              ),
                              Text(
                                state.data!.available_at.substring(0, 10),
                                style: TextStyle(
                                    fontFamily: 'MaruBuri',
                                    fontSize: 12,
                                    color: ColorConstants.primary),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              Text(
                                'To.',
                                style: TextStyle(
                                    fontFamily: 'MaruBuri',
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: ColorConstants.primary),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                state.data!.by_full_name,
                                style: TextStyle(
                                    fontFamily: 'MaruBuri',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstants.primary),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      state.data!.replies!.isNotEmpty
                          ? Text(
                              state.data!.replies!.first.description,
                              style: TextStyle(
                                  fontFamily: 'MaruBuri',
                                  fontSize: 14,
                                  color: ColorConstants.primary),
                            )
                          : MutationBuilder(
                              mutation: getSendMailReplyMutation(
                                onSuccess: (context, data) {
                                  context.go('/mails');
                                },
                                onError: (context, error, fallback) {
                                  print(error);
                                },
                              ),
                              builder: (context, state, mutate) => Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return '답장을 입력해주세요.';
                                        }
                                        return null;
                                      },
                                      controller: controller,
                                      maxLines: null,
                                      keyboardType: TextInputType.multiline,
                                      minLines: 8,
                                      decoration: InputDecoration(
                                        errorStyle: TextStyle(
                                          fontSize: 0,
                                        ),
                                        hintText: '답장을 적어주세요...',
                                        hintStyle: TextStyle(
                                            fontFamily: 'MaruBuri',
                                            fontSize: 14,
                                            color: ColorConstants.neutral),
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                          fontFamily: 'MaruBuri',
                                          fontSize: 14,
                                          color: ColorConstants.primary),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: FilledButton(
                                        onPressed: () {
                                          mutate(getReplyDTO());
                                        },
                                        child: const Text(
                                          '답장하기',
                                          style: TextStyle(
                                            fontFamily: 'MaruBuri',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
