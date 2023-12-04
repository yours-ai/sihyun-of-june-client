import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/models/CharacterColors.dart';
import 'package:project_june_client/actions/character/models/CharacterTheme.dart';
import 'package:project_june_client/providers/character_theme_provider.dart';
import 'package:project_june_client/widgets/common/modal/modal_widget.dart';
import 'package:project_june_client/widgets/common/title_underline.dart';
import 'package:project_june_client/widgets/menu_title_widget.dart';
import 'package:project_june_client/widgets/menu_widget.dart';
import 'package:project_june_client/widgets/common/modal/modal_choice_widget.dart';
import 'package:project_june_client/widgets/common/modal/modal_description_widget.dart';
import 'package:project_june_client/widgets/user_profile_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../actions/auth/actions.dart';
import '../../actions/auth/queries.dart';
import '../../constants.dart';
import '../../services.dart';
import '../../widgets/common/title_layout.dart';

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
          choiceColumn: ModalChoiceWidget(
            submitText: '네',
            onSubmit: () {
              logout();
              CharacterTheme defaultTheme = CharacterTheme(
                colors:
                    CharacterColors(primary: 4294923379, secondary: 4294932624),
                font: "NanumNoRyeogHaNeunDongHee",
              );
              ref.read(characterThemeProvider.notifier).state = defaultTheme;
              context.go('/login');
            },
            cancelText: '아니요',
            onCancel: () => context.pop(),
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
          description: ModalDescriptionWidget(
            descriptionWidget: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodySmall,
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
          ),
          choiceColumn: ModalChoiceWidget(
            submitText: '네',
            onSubmit: () {
              context.push('/withdraw');
              context.pop();
            },
            cancelText: '아니요',
            onCancel: () => context.pop(),
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
                return Column(
                  children: [
                    MenuWidget(
                      title: '포인트',
                      onPressed: () => context.push('/my-point'),
                      suffix: Row(
                        children: [
                          Text(
                            state.data?.point != null
                                ? '${transactionService.currencyFormatter.format(state.data?.point)} P'
                                : '',
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorConstants.primary,
                            ),
                          ),
                          Icon(
                            PhosphorIcons.caret_right_bold,
                            color: ColorConstants.primary,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                    MenuWidget(
                      title: '코인',
                      onPressed: () => context.push('/my-coin'),
                      suffix: Row(
                        children: [
                          Text(
                            state.data?.coin != null
                                ? '${transactionService.currencyFormatter.format(state.data?.coin)} 코인'
                                : '',
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorConstants.primary,
                            ),
                          ),
                          Icon(
                            PhosphorIcons.caret_right_bold,
                            color: ColorConstants.primary,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            MenuWidget(
              title: '친구 초대하고 포인트 받기',
              onPressed: () {
                context.push('/share');
              },
            ),
            MenuTitleWidget(title: '내 정보'),
            MenuWidget(
              title: '이름 변경하기',
              onPressed: () => context.push('/change-name'),
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
            QueryBuilder(
              query: getRefferalCodeQuery(),
              builder: (context, state) {
                return MenuWidget(
                  title: '의견 남기기',
                  onPressed: () {
                    print(state.data);
                    launchUrl(Uri.parse(
                        'https://form.sihyunofjune.com/feedback?ref=${state.data}'));
                  },
                );
              },
            ),
            MenuTitleWidget(title: '고객센터'),
            MenuWidget(
              title: '공지',
              onPressed: () => launchUrl(Uri.parse(Urls.notice)),
            ),
            MenuWidget(
              title: '문의하기',
              onPressed: () => launchUrl(Uri.parse(Urls.ask)),
            ),
            QueryBuilder(
              query: getRefferalCodeQuery(),
              builder: (context, state) {
                return MenuWidget(
                  title: '의견 남기기',
                  onPressed: () {
                    print(state.data);
                    launchUrl(Uri.parse(
                        'https://form.sihyunofjune.com/feedback?ref=${state.data}'));
                  },
                );
              },
            ),
            MenuWidget(
              title: '약관 및 정책',
              onPressed: () => context.push('/policy'),
            ),
          ],
        ),
      ),
    );
  }
}
