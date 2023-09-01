import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({super.key});

  @override
  State createState() => _StartingScreen();
}

class _StartingScreen extends State<StartingScreen> {
  _checkAuthAndLand() async {
    final prefs = await SharedPreferences.getInstance();
    // final isLandingViewed =
    //     prefs.getBool('isLandingViewed') ?? false; // TODO: 로그인 체크로 변경
    if (!context.mounted) return;
    FlutterNativeSplash.remove();
    context.go('/landing');
    // if (isLandingViewed) {
    //   context.go('/login');
    // } else {
    //   context.go('/landing');
    // }
  }

  @override
  void initState() {
    super.initState();

    _checkAuthAndLand();
  }

  @override
  Widget build(context) {
    return const Scaffold();
  }
}
