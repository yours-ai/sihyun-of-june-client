import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/widgets/menu_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../actions/auth/actions.dart';
import '../actions/auth/queries.dart';
import '../constants.dart';
import '../router.dart';
import '../widgets/common/title_layout.dart';
import '../widgets/modal_widget.dart';

class AllScreen extends StatefulWidget {
  const AllScreen({super.key});

  @override
  State<AllScreen> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  void _showLogoutModal() async {
    await showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return ModalWidget(
          title: '정말 로그아웃하시겠어요?',
          choiceColumn: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(ColorConstants.background),
                ),
                onPressed: () {
                  context.pop();
                },
                child: Text(
                  '아니요',
                  style: TextStyle(
                      fontSize: 14.0, color: ColorConstants.secondary),
                ),
              ),
              FilledButton(
                onPressed: () {
                  logout();
                  context.go('/login');
                },
                child: const Text(
                  '네',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showWithdrawModal() async {
    await showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return ModalWidget(
          title: '정말 탈퇴하시겠어요?',
          choiceColumn: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(ColorConstants.background),
                ),
                onPressed: () {
                  context.pop();
                },
                child: Text(
                  '아니요',
                  style: TextStyle(
                      fontSize: 14.0, color: ColorConstants.secondary),
                ),
              ),
              FilledButton(
                onPressed: () {
                  launchUrl(Uri.parse(Urls.withdraw));
                },
                child: const Text(
                  '네',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(context) {
    return SafeArea(
      child: TitleLayout(
        titleText: '전체',
        body: ListView(
          children: [
            QueryBuilder(
              query: getRetrieveMeQuery(),
              builder: (context, state) {
                return MenuWidget(
                  title: '내 코인',
                  onPressed: () => context.push('/my-coin'),
                  suffix: Row(
                    children: [
                      Text(
                        state.data?.coin.toString() ?? '',
                        style: TextStyle(
                            fontSize: 18,
                            color: ColorConstants.neutral,
                            fontWeight: FontWeight.normal),
                      ),
                      Icon(
                        PhosphorIcons.coin_vertical,
                        color: ColorConstants.neutral,
                        size: 18,)
                    ]
                  ),
                );
              },
            ),
            MenuWidget(
              title: '공지',
              onPressed: () => launchUrl(Uri.parse(Urls.notice)),
            ),
            MenuWidget(
              title: '자주 묻는 질문',
              onPressed: () => launchUrl(Uri.parse(Urls.faq)),
            ),
            MenuWidget(
              title: '문의하기',
              onPressed: () => launchUrl(Uri.parse(Urls.ask)),
            ),
            MenuWidget(
              title: '이름 변경하기',
              onPressed: () => context.push('/change-name'),
            ),
            MenuWidget(
              title: '이용약관',
              onPressed: () => launchUrl(Uri.parse(Urls.terms)),
            ),
            MenuWidget(
              title: '개인정보 처리방침',
              onPressed: () => launchUrl(Uri.parse(Urls.privacy)),
            ),
            MenuWidget(
              title: '로그아웃',
              onPressed: () {
                _showLogoutModal();
              },
            ),
            MenuWidget(
              title: '탈퇴하기',
              onPressed: () {
                _showWithdrawModal();
              },
            ),
          ],
        ),
      ),
    );
  }
}
