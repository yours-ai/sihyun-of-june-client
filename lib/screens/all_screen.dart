import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/widgets/menu_widget.dart';

import '../actions/auth/actions.dart';
import '../constants.dart';
import '../widgets/common/title_layout.dart';
import '../widgets/modal_widget.dart';

class AllScreen extends StatefulWidget {
  const AllScreen({super.key});

  @override
  State<AllScreen> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  bool _agreeShare = false;

  _showShareModal() async {
    if (_agreeShare == false) {
      final result = await showModalBottomSheet<void>(
        context: context,
        useRootNavigator: true,
        builder: (BuildContext context) {
          return ModalWidget(
            description: Column(
              children: [
                const SizedBox(
                  height: 26,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 0.0),
                  height: 20,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          '친구가 링크로 가입하면 50',
                          style: TextStyle(
                              fontSize: 14, color: ColorConstants.neutral),
                        ),
                        Icon(PhosphorIcons.coin_vertical,
                            size: 14, color: ColorConstants.neutral),
                        Text(
                          '을 받아요.',
                          style: TextStyle(
                              fontSize: 14, color: ColorConstants.neutral),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            title: '친구에게 서비스를 소개하고,\n무료 코인을 받아보세요!',
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
                    '됐어요',
                    style: TextStyle(
                        fontSize: 14.0, color: ColorConstants.secondary),
                  ),
                ),
                FilledButton(
                  onPressed: () {
                    // context.go('/landing');
                    _agreeShare = true;
                  },
                  child: const Text(
                    '친구에게 소개하고 50코인 받기',
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
  }

  @override
  Widget build(context) {
    return SafeArea(
      child: TitleLayout(
        titleText: '전체',
        body: Column(
          children: [
            Container(
              color: ColorConstants.background,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  splashFactory: NoSplash.splashFactory,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(left: 28, top: 30, bottom: 30),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '내 코인',
                        style: TextStyle(
                            fontSize: 18,
                            color: ColorConstants.black,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 28.0),
                      child: Container(
                        child: Row(
                          children: [
                            Text(
                              '80',
                              style: TextStyle(
                                fontSize: 18,
                                color: ColorConstants.neutral,
                              ),
                            ),
                            Icon(
                              PhosphorIcons.coin_vertical,
                              size: 20,
                              color: ColorConstants.neutral,
                            ),
                            Icon(
                              PhosphorIcons.caret_right,
                              size: 20,
                              color: ColorConstants.neutral,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                onPressed: () {
                  _showShareModal();
                },
              ),
            ),
            MenuWidget(title: '친구 초대하고, 50코인 받기'),
            MenuWidget(title: '공지'),
            MenuWidget(title: '자주 묻는 질문'),
            MenuWidget(title: '문의하기'),
            MenuWidget(title: '약관 및 정책 이해하기'),
            MenuWidget(
              title: '로그아웃',
              onPressed: () {
                logout();
                context.go('/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
