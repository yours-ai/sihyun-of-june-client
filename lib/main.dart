import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_june_client/screens/HomeScreen.dart';
import 'package:project_june_client/screens/LoginScreen.dart';
import 'package:project_june_client/screens/SplashScreen.dart';

final helloWorldProvider = Provider((_) => 'Hello world');

void main() {
  runApp(const ProviderScope(child: ProjectJuneApp()));
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child; // 페이지 트랜지션 비활성화
          },
        );
      },
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child; // 페이지 트랜지션 비활성화
          },
        );
      },
    ),
  ],
);

class ProjectJuneApp extends StatelessWidget {
  const ProjectJuneApp({super.key});

  @override
  Widget build(context) {
    return CupertinoApp.router(
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.black,
        scaffoldBackgroundColor: Color(0xFFFCFCFC),
      ),
      title: 'Project June',
      routerConfig: _router,
    );
  }
}
