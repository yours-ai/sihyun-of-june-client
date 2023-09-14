import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/screens/all_screen.dart';
import 'package:project_june_client/screens/mail_list_screen.dart';
import 'package:project_june_client/screens/mail_detail_screen.dart';
import 'package:project_june_client/screens/notification_list_screen.dart';
import 'package:project_june_client/screens/phone_login_screen.dart';
import 'package:project_june_client/screens/other_character_screen.dart';
import 'package:project_june_client/screens/my_character_screen.dart';
import 'package:project_june_client/screens/starting_screen.dart';
import 'package:project_june_client/screens/character_choice_screen.dart';
import 'package:project_june_client/screens/test_screen.dart';
import 'constants.dart';
import 'screens/landing_screen.dart';
import 'screens/login_screen.dart';
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
      builder: (context, state) => CharacterChoiceScreen(),
    ),
    GoRoute(
      path: '/other-character/:id',
      builder: (context, state) =>
          OtherCharacterScreen(id: int.tryParse(state.pathParameters['id']!)),
    ),
    GoRoute(
      path: '/mail-view/:id',
      builder: (context, state) =>
          MailDetailScreen(id: int.tryParse(state.pathParameters['id']!)),
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
                  id: int.tryParse(state.pathParameters['id']!)),
            ),
          ],
        ),
        GoRoute(
          path: TabRoutePaths.notificationList,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: NavbarLayout(
                routePath: state.matchedLocation,
                child: const NotificationListScreen(),
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
                child: const AllScreen(),
              ),
            );
          },
        ),
      ],
    ),
    GoRoute(
        path: '/character-test',
        builder: (context, state) => CharacterTestScreen()),
  ],
);
