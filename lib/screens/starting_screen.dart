import 'dart:io';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/actions.dart';
import 'package:project_june_client/actions/character/actions.dart';
import 'package:project_june_client/actions/character/models/CharacterTheme.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/main.dart';
import 'package:project_june_client/services.dart';

import '../actions/notification/actions.dart';
import '../main.dart';

class StartingScreen extends ConsumerStatefulWidget {
  const StartingScreen({super.key});

  @override
  StartingScreenState createState() => StartingScreenState();
}

class StartingScreenState extends ConsumerState<StartingScreen> {
  _checkAuthAndLand() async {
    final isLogined = await loadIsLogined();
    FlutterNativeSplash.remove();
    if (!context.mounted) return;

    await _initializeNotificationHandlerIfAccepted();
    await _checkUpdateAvailable();

    if (isLogined == false) {
      context.go('/landing');
      return;
    }
    final push = await getPushIfPushClicked();
    if (push != null) {
      notificationService.handleFCMMessageTap(push);
      return;
    }
    final character = await getRetrieveMyCharacterQuery().result;
    if (character.data!.isNotEmpty) {
      CharacterTheme characterTheme = character.data![0].theme!;
      ref.read(characterThemeProvider.notifier).state = characterTheme;
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

  _checkUpdateAvailable() async {
    await updateService.forceUpdateByRemoteConfig(context);
    if (Platform.isAndroid) {
      updateService.checkAndUpdateAndroidApp();
    }

    if (Platform.isIOS) {
      await updateService.checkAndUpdateIOSApp(context);
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
    onelinkService.appsFlyerInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onelinkService.appsflyerSdk!.onDeepLinking((DeepLinkResult dp) {
        if (dp.status == Status.FOUND) {
          ref.read(deepLinkProvider.notifier)?.state = dp.deepLink;
          if(dp.deepLink?.deepLinkValue == null || dp.deepLink?.deepLinkValue == '') return;
          context.go('${dp.deepLink?.deepLinkValue}'); //ToDo 딥링크로 이동하기 위해서는 비동기 함수 처리를 해야함.
        }
      });
      _checkAuthAndLand();
    });
  }

  @override
  Widget build(context) {
    return const Scaffold();
  }
}
