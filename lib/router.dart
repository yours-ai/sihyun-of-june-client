import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/screens/all_screen.dart';
import 'package:project_june_client/screens/mail_list_screen.dart';
import 'package:project_june_client/screens/mail_view_screen.dart';
import 'package:project_june_client/screens/notification_list_screen.dart';
import 'package:project_june_client/screens/profile_screen.dart';
import 'package:project_june_client/screens/starting_screen.dart';

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
    ),
    GoRoute(
      path: '/mail/view',
      builder: (context, state) => const MailViewScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
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
          builder: (context, state) => const MailListScreen(),
        ),
        GoRoute(
          path: TabRoutePaths.notificationList,
          builder: (context, state) => const NotificationListScreen(),
        ),
        GoRoute(
          path: TabRoutePaths.all,
          builder: (context, state) => const AllScreen(),
        ),
      ],
    ),
  ],
);
