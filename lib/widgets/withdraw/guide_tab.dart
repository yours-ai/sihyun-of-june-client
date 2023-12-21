import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/dtos.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../actions/auth/actions.dart';
import '../../constants.dart';

class GuideTabWidget extends StatefulWidget {
  const GuideTabWidget(
      {super.key, required this.onWithdraw, required this.dto});

  final void Function() onWithdraw;
  final QuitReasonDTO dto;

  @override
  _GuideTabWidgetState createState() => _GuideTabWidgetState();
}

class _GuideTabWidgetState extends State<GuideTabWidget> {
  @override
  Widget build(BuildContext context) {
    return QueryBuilder(
      query: getRetrieveMeQuery(),
      builder: (context, state) {
        return TitleLayout(
          withAppBar: true,
          title: Text(
            '탈퇴 주의사항',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                state.data != null
                    ? state.data!.env == 'apple'
                        ? Column(
                            children: [
                              Text(
                                '애플 계정 연결 해제를 위해 아래 링크를 따라 주세요.',
                                style: TextStyle(color: ColorConstants.primary),
                              ),
                              const SizedBox(height: 20),
                              TextButton(
                                  onPressed: () =>
                                      launchUrl(Uri.parse(Urls.appleWithdraw)),
                                  child: Text(Urls.appleWithdraw)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(
                                          text: Urls.appleWithdraw));
                                    },
                                    child: Text(
                                      '링크 복사하기',
                                      style: TextStyle(
                                          color: ColorConstants.primary),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              state.data!.env == 'sms'
                                  ? Text(
                                      '카카오톡으로 가입하셨다면,',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: ColorConstants.primary,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              Text(
                                '계정 연결 해제를 위해 다음의 단계를 따라 주세요.',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstants.primary,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                '카카오톡 설정 > 카카오 계정 > 연결된 서비스 관리 > ‘유월의 시현이’ 선택 > 연결 끊기',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: ColorConstants.primary,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Text(
                                '상세 안내',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstants.primary,
                                ),
                              ),
                              Text(
                                "1. 카카오톡을 실행하여 전체 설정으로 들어갑니다.\n2. 설정에서 '카카오 계정'을 선택해주시고 \n'연결된 서비스 관리'를 선택해주세요.\n3. '유월의 시현이'를 선택하여 '연결 끊기'를 눌러주세요.",
                                style: TextStyle(color: ColorConstants.primary),
                              ),
                            ],
                          )
                    : const SizedBox.shrink()
              ],
            ),
          ),
          actions: MutationBuilder(
            mutation: getWithdrawUserMutation(onSuccess: (res, arg) async {
              widget.onWithdraw();
              await Future.delayed(const Duration(seconds: 3));
              await logout();
              context.go('/login');
            }),
            builder: (context, state, mutate) {
              return OutlinedButton(
                onPressed: () {
                  mutate(widget.dto);
                },
                child: Text(
                  '탈퇴하기',
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorConstants.gray,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
