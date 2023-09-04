import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/actions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({super.key});

  @override
  State createState() => _StartingScreen();
}

class _StartingScreen extends State<StartingScreen> {
  _checkAuthAndLand() async {
    final isLogined = await loadServerToken();
    FlutterNativeSplash.remove();
    if (!context.mounted) return;
    if (isLogined) {
      context.go('/select');
    } else {
      context.go('/landing');
    }
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
