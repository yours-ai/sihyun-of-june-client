import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/contrib/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartingScreen extends HookWidget {
  const StartingScreen({super.key});

  @override
  Widget build(context) {
    useAsyncEffect(() async {
      final prefs = await SharedPreferences.getInstance();
      final isLandingViewed =
          prefs.getBool('isLandingViewed') ?? false; // TODO: 로그인 체크로 변경
      if (!context.mounted) return;
      FlutterNativeSplash.remove();
      if (isLandingViewed) {
        context.go('/login');
      } else {
        context.go('/landing');
      }
      return null;
    }, []);
    return Container();
  }
}
