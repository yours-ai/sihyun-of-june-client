import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/models/CharacterColors.dart';
import 'package:project_june_client/actions/character/models/CharacterTheme.dart';
import 'package:project_june_client/main.dart';
import 'package:project_june_client/widgets/common/title_underline.dart';
import 'package:project_june_client/widgets/menu_widget.dart';
import 'package:project_june_client/widgets/user_profile_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../actions/auth/actions.dart';
import '../actions/auth/queries.dart';
import '../constants.dart';
import '../services.dart';
import '../widgets/common/title_layout.dart';
import '../widgets/modal_widget.dart';

class AllScreen extends ConsumerStatefulWidget {
  const AllScreen({super.key});

  @override
  AllScreenState createState() => AllScreenState();
}

class AllScreenState extends ConsumerState<AllScreen> {
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
              OutlinedButton(
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
                    fontSize: 16,
                    color: ColorConstants.neutral,
                    fontWeight: FontWeightConstants.semiBold,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              FilledButton(
                onPressed: () {
                  logout();
                  CharacterTheme defaultTheme = CharacterTheme(
                    colors: CharacterColors(
                        primary: 4294923379, secondary: 4294932624),
                    font: "NanumNoRyeogHaNeunDongHee",
                  );
                  ref.read(characterThemeProvider.notifier).state =
                      defaultTheme;
                  context.go('/login');
                },
                child: Text(
                  '네',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeightConstants.semiBold,
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
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    height: 1.6,
                    color: ColorConstants.gray,
                    fontSize: 16.0,
                  ),
                  children: [
                    const TextSpan(
                      text: '탈퇴하기 신청을 하면 이런 내용이 전부 삭제되어요.\n',
                    ),
                    TextSpan(
                      text: '- 시현이 또는 우빈이와 함께 나누었던 ',
                      children: [
                        TextSpan(
                          text: '편지\n',
                          style: TextStyle(
                            color: ColorConstants.gray,
                            fontWeight: FontWeightConstants.semiBold,
                          ),
                        ),
                        const TextSpan(
                          text: '- 앞으로 새로운 친구들을 만나볼 기회',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
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
                    fontSize: 16,
                    color: ColorConstants.neutral,
                    fontWeight: FontWeightConstants.semiBold,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              FilledButton(
                onPressed: () {
                  context.push('/withdraw');
                  context.pop();
                },
                child: Text(
                  '네',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeightConstants.semiBold,
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
        title: const Center(
          child: TitleUnderline(
            titleText: '전체',
          ),
        ),
        body: ListView(
          children: [
            const UserProfileWidget(),
            QueryBuilder(
              query: getRetrieveMeQuery(),
              builder: (context, state) {
                return MenuWidget(
                  title: '내 코인',
                  onPressed: () => context.push('/my-coin'),
                  suffix: Row(
                    children: [
                      Text(
                        state.data?.coin != null
                            ? transactionService.currencyFormatter
                                .format(state.data?.coin)
                            : '',
                        style: TextStyle(
                          fontSize: 16,
                          color: ColorConstants.primary,
                          fontWeight: FontWeightConstants.semiBold,
                        ),
                      ),
                      Icon(
                        PhosphorIcons.coin_vertical,
                        color: ColorConstants.primary,
                        size: 24,
                      ),
                      Icon(
                        PhosphorIcons.caret_right_bold,
                        color: ColorConstants.primary,
                        size: 24,
                      ),
                    ],
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
