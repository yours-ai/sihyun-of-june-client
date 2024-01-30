import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/screens/all_tab/all_tab_screen.dart';
import 'package:project_june_client/screens/all_tab/coin_charge_screen.dart';
import 'package:project_june_client/screens/all_tab/coin_log_screen.dart';
import 'package:project_june_client/screens/all_tab/my_point_screen.dart';
import 'package:project_june_client/screens/all_tab/point_change_screen.dart';
import 'package:project_june_client/screens/all_tab/point_log_screen.dart';
import 'package:project_june_client/screens/all_tab/share_screen.dart';
import 'package:project_june_client/screens/assignment/assignment_screen.dart';
import 'package:project_june_client/screens/assignment/decide_method_screen.dart';
import 'package:project_june_client/screens/assignment/new_user_assignment_starting_screen.dart';
import 'package:project_june_client/screens/character_selection/deciding_screen.dart';
import 'package:project_june_client/screens/character_selection/confirm_screen.dart';
import 'package:project_june_client/screens/character_test/confirm_screen.dart';
import 'package:project_june_client/screens/mail/mail_list_screen.dart';
import 'package:project_june_client/screens/mail/mail_detail_screen.dart';
import 'package:project_june_client/screens/all_tab/change_name_screen.dart';
import 'package:project_june_client/screens/all_tab/my_coin_screen.dart';
import 'package:project_june_client/screens/notification_list_screen.dart';
import 'package:project_june_client/screens/login/phone_login_screen.dart';
import 'package:project_june_client/screens/character_profile/other_character_screen.dart';
import 'package:project_june_client/screens/character_profile/my_character_screen.dart';
import 'package:project_june_client/screens/all_tab/policy_screen.dart';
import 'package:project_june_client/screens/retest/retest_confirm_screen.dart';
import 'package:project_june_client/screens/retest/retest_extend_screen.dart';
import 'package:project_june_client/screens/retest/retest_info_screen.dart';
import 'package:project_june_client/screens/starting_screen.dart';
import 'package:project_june_client/screens/character_test/deciding_screen.dart';
import 'package:project_june_client/screens/character_test/test_screen.dart';
import 'package:project_june_client/screens/all_tab/withdraw_screen.dart';
import 'actions/character/models/CharacterTheme.dart';
import 'constants.dart';
import 'screens/login/landing_screen.dart';
import 'screens/login/login_screen.dart';
import 'widgets/common/navbar_layout.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      path: RoutePaths.starting,
      builder: (context, state) => const StartingScreen(),
    ),
    GoRoute(
      path: RoutePaths.landing,
      builder: (context, state) => const LandingScreen(),
    ),
    GoRoute(
      path: RoutePaths.login,
      builder: (context, state) => const LoginScreen(),
      routes: [
        GoRoute(
          path: SubRoutePaths.byPhone,
          builder: (context, state) => const PhoneLoginScreen(),
        ),
      ],
    ),
    GoRoute(
      path: RoutePaths.mailList,
      pageBuilder: (context, state) {
        return NoTransitionPage(
          key: state.pageKey,
          child: NavbarLayout(
            routePath: state.matchedLocation,
            child: const MailListScreen(),
          ),
        );
      },
      routes: [
        GoRoute(
          path: SubRoutePaths.myCharacter,
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const MyCharacterScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration:
                const Duration(milliseconds: 300), // 전환 지속 시간 설정
          ),
        ),
        GoRoute(
          path: '${SubRoutePaths.mailDetail}/:id',
          builder: (context, state) =>
              MailDetailScreen(id: int.tryParse(state.pathParameters['id']!)!),
        ),
        GoRoute(
          path: SubRoutePaths.decideAssignmentMethod,
          builder: (context, state) => const DecideAssignmentMethodScreen(),
        ),
      ],
    ),
    GoRoute(
      path: RoutePaths.notificationList,
      pageBuilder: (context, state) {
        final redirectLink = state.extra as String?;
        return NoTransitionPage(
          key: state.pageKey,
          child: NavbarLayout(
            routePath: state.matchedLocation,
            child: NotificationListScreen(redirectLink),
          ),
        );
      },
    ),
    GoRoute(
      path: RoutePaths.all,
      pageBuilder: (context, state) {
        return NoTransitionPage(
          key: state.pageKey,
          child: NavbarLayout(
            routePath: state.matchedLocation,
            child: const AllTabScreen(),
          ),
        );
      },
      routes: [
        GoRoute(
          path: SubRoutePaths.myPoint,
          builder: (context, state) => const MyPointScreen(),
          routes: [
            GoRoute(
                path: SubRoutePaths.pointLog,
                builder: (context, state) => const PointLogScreen()),
            GoRoute(
                path: SubRoutePaths.pointCharge,
                builder: (context, state) => const PointChangeScreen()),
          ],
        ),
        GoRoute(
          path: SubRoutePaths.myCoin,
          builder: (context, state) => const MyCoinScreen(),
          routes: [
            GoRoute(
                path: SubRoutePaths.coinLog,
                builder: (context, state) => const CoinLogScreen()),
            GoRoute(
                path: SubRoutePaths.coinCharge,
                builder: (context, state) => const CoinChargeScreen()),
          ],
        ),
        GoRoute(
          path: SubRoutePaths.share,
          builder: (context, state) => const ShareScreen(),
        ),
        GoRoute(
          path: SubRoutePaths.changeName,
          builder: (context, state) => const ChangeNameScreen(),
        ),
        GoRoute(
          path: SubRoutePaths.withdraw,
          builder: (context, state) => const WithdrawScreen(),
        ),
        GoRoute(
          path: SubRoutePaths.policy,
          builder: (context, state) => const PolicyScreen(),
        ),
      ],
    ),
    GoRoute(
      path: RoutePaths.characterTest,
      builder: (context, state) => const CharacterTestScreen(),
    ),
    GoRoute(
      path: RoutePaths.testDeciding,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const TestDecidingScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300), // 전환 지속 시간 설정
      ),
    ),
    GoRoute(
      path: RoutePaths.testConfirm,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return TestConfirmScreen(
          selectedCharacterId: extra['selectedCharacterId'] as int,
          testId: extra['testId'] as int,
          selectedCharacterFirstName: extra['selectedCharacterFirstName'],
          selectedCharacterTheme:
              extra['selectedCharacterTheme'] as CharacterTheme,
        );
      },
    ),
    GoRoute(
      path: RoutePaths.selectionDeciding,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const CharacterSelectionDecidingScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300), // 전환 지속 시간 설정
      ),
    ),
    GoRoute(
      path: RoutePaths.selectionConfirm,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return CharacterSelectionConfirmScreen(
          characterId: extra['id'] as int,
          firstName: extra['firstName'],
          primaryColor: extra['primaryColor'] as int,
          secondaryColor: extra['secondaryColor'] as int,
        );
      },
    ),
    GoRoute(
      path: '${RoutePaths.otherCharacter}/:id',
      builder: (context, state) =>
          OtherCharacterScreen(id: int.tryParse(state.pathParameters['id']!)!),
    ),
    GoRoute(
      path: RoutePaths.assignment,
      builder: (context, state) => const AssignmentScreen(),
    ),
    GoRoute(
      path: RoutePaths.newUserAssignmentStarting,
      builder: (context, state) => const NewUserAssignmentStartingScreen(),
    ),
    GoRoute(
      path: RoutePaths.retest,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return RetestInfoScreen(
          characterIds: extra['characterIds'] as List<int>,
          firstName: extra['firstName'] as String,
        );
      },
      routes: [
        GoRoute(
          path: SubRoutePaths.extend,
          builder: (context, state) {
            return RetestExtendScreen(
              firstName: state.extra as String,
            );
          },
        ),
        GoRoute(
          path: SubRoutePaths.confirm,
          builder: (context, state) {
            return RetestConfirmScreen(
              firstName: state.extra as String,
            );
          },
        ),
      ],
    ),
  ],
);
