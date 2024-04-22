import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/screens/all_tab/all_tab_screen.dart';
import 'package:project_june_client/screens/all_tab/coin_charge_screen.dart';
import 'package:project_june_client/screens/all_tab/coin_log_screen.dart';
import 'package:project_june_client/screens/all_tab/my_point_screen.dart';
import 'package:project_june_client/screens/all_tab/point_change_screen.dart';
import 'package:project_june_client/screens/all_tab/point_log_screen.dart';
import 'package:project_june_client/screens/all_tab/share_screen.dart';
import 'package:project_june_client/screens/mail/mail_list_screen.dart';
import 'package:project_june_client/screens/mail/mail_detail_screen.dart';
import 'package:project_june_client/screens/all_tab/change_name_screen.dart';
import 'package:project_june_client/screens/all_tab/my_coin_screen.dart';
import 'package:project_june_client/screens/notification_list_screen.dart';
import 'package:project_june_client/screens/login/phone_login_screen.dart';
import 'package:project_june_client/screens/mail/my_character_screen.dart';
import 'package:project_june_client/screens/all_tab/policy_screen.dart';
import 'package:project_june_client/screens/starting_screen.dart';
import 'package:project_june_client/screens/all_tab/withdraw_screen.dart';
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
  ],
);
