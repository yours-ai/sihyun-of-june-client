import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/actions.dart';
import 'package:project_june_client/actions/character/actions.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/services.dart';

import '../actions/notification/actions.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({super.key});

  @override
  State createState() => _StartingScreen();
}

class _StartingScreen extends State<StartingScreen> {
  _checkAuthAndLand() async {
    final isLogined = await loadIsLogined();
    FlutterNativeSplash.remove();
    if (!context.mounted) return;

    await _initializeNotificationHandlerIfAccepted();

    if (isLogined == false) {
      context.go('/landing');
      return;
    }
    final push = await getPushIfPushClicked();
    if (push != null) {
      notificationService.handleFCMMessageTap(push);
      return;
    }
    final character = await fetchMyCharacter();
    if (character.isNotEmpty) {
      context.go('/mails');
      return;
    } else {
      final testStatus = await getTestStatusQuery().result;
      if (testStatus.data == 'WAITING_CONFIRM') {
        context.go('/character-choice');
      } else {
        context.go('/character-test');
      }
    }
  }

  Future<RemoteMessage?> getPushIfPushClicked() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    return initialMessage;
  }

  _initializeNotificationHandlerIfAccepted() async {
    final isAccepted = await getIsNotificationAccepted();
    if (isAccepted == true) {
      notificationService.initializeNotificationHandlers();
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkAuthAndLand();
    });
  }

  @override
  Widget build(context) {
    return Scaffold();
  }
}
