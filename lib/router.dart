import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/screens/all_tab/all_tab_screen.dart';
import 'package:project_june_client/screens/all_tab/coin_charge_screen.dart';
import 'package:project_june_client/screens/all_tab/coin_log_screen.dart';
import 'package:project_june_client/screens/all_tab/my_point_screen.dart';
import 'package:project_june_client/screens/all_tab/point_change_screen.dart';
import 'package:project_june_client/screens/all_tab/point_log_screen.dart';
import 'package:project_june_client/screens/all_tab/share_screen.dart';
import 'package:project_june_client/screens/character_selection/decide_method_screen.dart';
import 'package:project_june_client/screens/character_selection/decided_character_screen.dart';
import 'package:project_june_client/screens/character_selection/decided_confirm_screen.dart';
import 'package:project_june_client/screens/character_selection/deciding_screen.dart';
import 'package:project_june_client/screens/character_selection/start_screen.dart';
import 'package:project_june_client/screens/mail/mail_list_screen.dart';
import 'package:project_june_client/screens/mail/mail_detail_screen.dart';
import 'package:project_june_client/screens/all_tab/name_change_screen.dart';
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
import 'package:project_june_client/screens/character_test/character_choice_screen.dart';
import 'package:project_june_client/screens/character_test/test_screen.dart';
import 'package:project_june_client/screens/all_tab/withdraw_screen.dart';
import 'constants.dart';
import 'screens/login/landing_screen.dart';
import 'screens/login/login_screen.dart';
import 'widgets/common/navbar_layout.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const StartingScreen(),
    ),
    GoRoute(
      path: '/landing',
      builder: (context, state) => const LandingScreen(),
    ),
    GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
        routes: [
          GoRoute(
            path: 'by-phone',
            builder: (context, state) => const PhoneLoginScreen(),
          ),
        ]),
    GoRoute(
      path: '/character-choice',
      builder: (context, state) => const CharacterChoiceScreen(),
    ),
    GoRoute(
      path: '/other-character/:id',
      builder: (context, state) =>
          OtherCharacterScreen(id: int.tryParse(state.pathParameters['id']!)!),
    ),
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (context, state, child) {
        // TODO(@narayo9): shell route 조회 가능해지면 공용 navbar layout으로 변경
        // return NavbarLayout(
        //   routePath: state.matchedLocation,
        //   child: child,
        // );
        return child;
      },
      routes: [
        GoRoute(
          path: TabRoutePaths.mailList,
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
              path: 'my-character',
              builder: (context, state) => const MyCharacterScreen(),
            ),
            GoRoute(
              path: 'detail/:id',
              builder: (context, state) => MailDetailScreen(
                  id: int.tryParse(state.pathParameters['id']!)!),
            ),
          ],
        ),
        GoRoute(
          path: TabRoutePaths.notificationList,
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
          path: TabRoutePaths.all,
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
                path: 'my-point',
                builder: (context, state) => const MyPointScreen(),
                routes: [
                  GoRoute(
                      path: 'log',
                      builder: (context, state) => const PointLogScreen()),
                  GoRoute(
                      path: 'charge',
                      builder: (context, state) => const PointChangeScreen()),
                ]),
            GoRoute(
                path: 'my-coin',
                builder: (context, state) => const MyCoinScreen(),
                routes: [
                  GoRoute(
                      path: 'log',
                      builder: (context, state) => const CoinLogScreen()),
                  GoRoute(
                      path: 'charge',
                      builder: (context, state) => const CoinChargeScreen()),
                ]),
            GoRoute(
              path: 'share',
              builder: (context, state) => const ShareScreen(),
            ),
            GoRoute(
              path: 'change-name',
              builder: (context, state) => const NameChangeScreen(),
            ),
            GoRoute(
              path: 'withdraw',
              builder: (context, state) => const WithdrawScreen(),
            ),
            GoRoute(
              path: 'policy',
              builder: (context, state) => const PolicyScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/character-test',
      builder: (context, state) => const CharacterTestScreen(),
    ),
    GoRoute(
      path: '/retest',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return RetestInfoScreen(
          characterIds: extra['characterIds'] as List<int>,
          firstName: extra['firstName'] as String,
        );
      },
      routes: [
        GoRoute(
          path: 'extend',
          builder: (context, state) {
            return RetestExtendScreen(
              firstName: state.extra as String,
            );
          },
        ),
        GoRoute(
          path: 'confirm',
          builder: (context, state) {
            return RetestConfirmScreen(
              firstName: state.extra as String,
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/character-selection-start',
      builder: (context, state) => CharacterSelectionStartScreen(
        state.extra as int?,
      ),
      routes: [
        GoRoute(
          path: 'decide-method',
          builder: (context, state) => CharacterSelectionDecideMethodScreen(
            state.extra as int?,
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/character-selection-deciding',
      builder: (context, state) => const CharacterSelectionDecidingScreen(),
      routes: [
        GoRoute(
          path: 'character/:id',
          name: DecidedRouteNames.character,
          builder: (context, state) => CharacterSelectionDecidedCharacterScreen(
            id: int.tryParse(state.pathParameters['id']!)!,
          ),
        ),
        GoRoute(
          path: 'confirm',
          name: DecidedRouteNames.confirm,
          builder: (context, state) => CharacterSelectionDecidedConfirmScreen(
            id: int.tryParse(state.uri.queryParameters['id']!)!,
            firstName: state.uri.queryParameters['firstName']!,
            primaryColor:
                int.tryParse(state.uri.queryParameters['primaryColor']!)!,
            secondaryColor:
                int.tryParse(state.uri.queryParameters['secondaryColor']!)!,
          ),
        ),
      ],
    ),
  ],
);
