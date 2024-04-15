import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/widgets/common/modal/modal_widget.dart';
import 'package:project_june_client/widgets/common/title_underline.dart';
import 'package:project_june_client/widgets/common/menu/menu_title_widget.dart';
import 'package:project_june_client/widgets/common/menu/menu_widget.dart';
import 'package:project_june_client/widgets/common/modal/modal_choice_widget.dart';
import 'package:project_june_client/widgets/common/modal/modal_description_widget.dart';
import 'package:project_june_client/widgets/user_profile_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../actions/auth/actions.dart';
import '../../actions/auth/queries.dart';
import '../../constants.dart';
import '../../services.dart';
import '../../widgets/common/title_layout.dart';

class AllTabScreen extends ConsumerStatefulWidget {
  const AllTabScreen({super.key});

  @override
  AllTabScreenState createState() => AllTabScreenState();
}

class AllTabScreenState extends ConsumerState<AllTabScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? reloadAllController;
  Animation<double>? reloadAllFadeAnimation;

  @override
  void initState() {
    super.initState();
    reloadAllController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100), // 애니메이션 지속 시간
    );
    reloadAllFadeAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(reloadAllController!);
  }

  void _showLogoutModal() async {
    await showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return ModalWidget(
          title: '정말 로그아웃하시겠어요?',
          choiceColumn: ModalChoiceWidget(
            submitText: '네',
            onSubmit: () async {
              await logout().then((_) => context.go(RoutePaths.login));
            },
            cancelText: '아니요',
            onCancel: () async => context.pop(),
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
                    text: '- 서로 함께 나누었던 ',
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
            onSubmit: () async {
              context.push(RoutePaths.allWithdraw);
            },
            cancelText: '아니요',
            onCancel: () async => context.pop(),
          ),
        );
      },
    );
  }

  @override
  Widget build(context) {
    final myCharactersQuery = fetchMyCharactersQuery();
    final retrieveMeQuery = fetchMeQuery();
    return SafeArea(
      child: TitleLayout(
        title: const Center(
          child: TitleUnderline(
            titleText: '설정',
          ),
        ),
        body: RefreshIndicator.adaptive(
          onRefresh: () async {
            HapticFeedback.lightImpact();
            reloadAllController!.forward().then((_) async {
              await myCharactersQuery.refetch();
              await retrieveMeQuery.refetch();
              reloadAllController!.reverse();
            });
          },
          child: FadeTransition(
            opacity: reloadAllFadeAnimation!,
            child: ListView(
              children: [
                UserProfileWidget(myCharactersQuery, retrieveMeQuery),
                QueryBuilder(
                  query: retrieveMeQuery,
                  builder: (context, state) {
                    return Column(
                      children: [
                        MenuWidget(
                          title: '포인트',
                          onPressed: () => context.push(RoutePaths.allMyPoint),
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
                          onPressed: () => context.push(RoutePaths.allMyCoin),
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
                    context.push(RoutePaths.allShare);
                  },
                ),
                QueryBuilder(
                  query: myCharactersQuery,
                  builder: (context, state) => MenuWidget(
                    title: '상대 변경하기',
                    onPressed: () {
                      if (state.status == QueryStatus.success) {
                        var characterList = state.data;
                        characterList ??= [];
                        characterService.showCharacterChangeModal(
                          characterList: characterList,
                          context: context,
                          ref: ref,
                        );
                      }
                    },
                  ),
                ),
                const MenuTitleWidget(title: '내 정보'),
                MenuWidget(
                  title: '이름 변경하기',
                  onPressed: () => context.push(RoutePaths.allChangeName),
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
                const MenuTitleWidget(title: '고객센터'),
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
                QueryBuilder(
                  query: fetchReferralCodeQuery(),
                  builder: (context, state) {
                    return MenuWidget(
                      title: '의견 남기기',
                      onPressed: () {
                        launchUrl(Uri.parse(
                            'https://form.sihyunofjune.com/feedback?ref=${state.data}'));
                      },
                    );
                  },
                ),
                MenuWidget(
                  title: '약관 및 정책',
                  onPressed: () => context.push(RoutePaths.allPolicy),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
