import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/actions.dart';
import 'package:project_june_client/actions/character/actions.dart';
import 'package:project_june_client/actions/character/queries.dart';

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

    if (isLogined == false) {
      context.go('/login');
    } else {
      final character = await fetchCharacter();
      if (character.isNotEmpty) {
        context.go('/mails');
        return;
      }else {
        final testStatus = await getTestStatusQuery().result;
        if (testStatus.data == 'WAITING_CONFIRM') {
          context.go('/result');
        } else {
          context.go('/test');
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _checkAuthAndLand();
  }

  @override
  Widget build(context) {
    return Scaffold();
  }
}
