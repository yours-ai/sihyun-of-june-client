import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/screens/all_screen.dart';
import 'package:project_june_client/screens/mail_list_screen.dart';
import 'package:project_june_client/screens/mail_view_screen.dart';
import 'package:project_june_client/screens/notification_list_screen.dart';
import 'package:project_june_client/screens/phone_login_screen.dart';
import 'package:project_june_client/screens/other_character_screen.dart';
import 'package:project_june_client/screens/profile_screen.dart';
import 'package:project_june_client/screens/starting_screen.dart';
import 'package:project_june_client/screens/character_choice_screen.dart';
import 'package:project_june_client/screens/test_screen.dart';
import 'constants.dart';
import 'screens/landing_screen.dart';
import 'screens/login_screen.dart';
import 'widgets/common/navbar_layout.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
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
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
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
          MailViewScreen(id: int.tryParse(state.pathParameters['id']!)),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return NavbarLayout(
          routePath: state.matchedLocation,
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: TabRoutePaths.mailList,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: const MailListScreen(),
            );
          },
        ),
        GoRoute(
          path: TabRoutePaths.notificationList,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: const NotificationListScreen(),
            );
          },
        ),
        GoRoute(
          path: TabRoutePaths.all,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: const AllScreen(),
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
