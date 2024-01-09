import 'dart:io';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/actions.dart';
import 'package:project_june_client/actions/character/models/CharacterColors.dart';
import 'package:project_june_client/actions/character/models/CharacterTheme.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/globals.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/providers/deep_link_provider.dart';
import 'package:project_june_client/providers/user_provider.dart';
import 'package:project_june_client/services.dart';

import '../actions/notification/actions.dart';
import '../widgets/common/alert/alert_description_widget.dart';
import '../widgets/common/alert/alert_widget.dart';

class StartingScreen extends ConsumerStatefulWidget {
  const StartingScreen({super.key});

  @override
  StartingScreenState createState() => StartingScreenState();
}

class StartingScreenState extends ConsumerState<StartingScreen> {
  _checkAuthAndLand() async {
    final isLogined = await loadIsLogined();
    FlutterNativeSplash.remove();

    await _checkAppAvailability();
    await _checkUpdateAvailable();

    if (isLogined == false) {
      context.go('/landing');
      return;
    }
    final testStatus = await getTestStatusQuery().result;
    if (testStatus.data!['status'] == 'WAITING_CONFIRM') {
      context.go('/character-choice');
    } else if (testStatus.data!['status'] == 'CONFIRMED') {
      final character = await getRetrieveMyCharacterQuery().result;

      late CharacterTheme characterTheme;
      final selectedCharacterId =
          await characterService.getSelectedCharacterId();
      if (selectedCharacterId == null) {
        ref.read(selectedCharacterProvider.notifier).state =
            character.data![0].id;
        characterTheme = character.data![0].theme!;
        await characterService.saveSelectedCharacterId(character.data![0].id);
      } else {
        ref.read(selectedCharacterProvider.notifier).state =
            selectedCharacterId;
        characterTheme = character.data!
            .where((character) => character.id == selectedCharacterId)
            .first
            .theme!;
      }
      ref.read(characterThemeProvider.notifier).state = characterTheme;
      final allCharacters = await getAllCharactersQuery().result;
      ref.read(isEnableToRetestProvider.notifier).state =
          character.data!.length != allCharacters.data!.length;
      await _initializeNotificationHandlerIfAccepted(characterTheme.colors!);
      final push = await getPushIfPushClicked();
      if (push != null) {
        notificationService.handleFCMMessageTap(push);
        return;
      }
      context.go('/mails');
      return;
    } else {
      // if(testStatus.data!['test_reason'] == 'character_test') {
      //   context.go('/character-test');
      // } else if(testStatus.data!['test_reason'] == 'character_selection') {
      //   context.go('/character-selection-deciding');
      // } else {
      //   scaffoldMessengerKey.currentState?.showSnackBar(
      //     const SnackBar(
      //       content: Text(
      //         '서버에 문제가 발생했습니다. 잠시 후 다시 시도해주세요.',
      //       ),
      //     ),
      //   );
      //   context.go('/landing');
      // }
      context.go('/character-test');
    }
  }

  _checkAppAvailability() async {
    FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(minutes: 1),
    ));
    await remoteConfig.fetchAndActivate();
    if (remoteConfig.getBool('app_available') == false) {
      return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            child: AlertWidget(
              title: remoteConfig.getString('app_disable_title'),
              content: AlertDescriptionWidget(
                description: remoteConfig.getString('app_disable_description'),
              ),
            ),
          );
        },
      );
    } else {
      await updateService.forceUpdateByRemoteConfig(context, remoteConfig);
    }
  }

  _checkUpdateAvailable() async {
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

  _initializeNotificationHandlerIfAccepted(
      CharacterColors characterColors) async {
    final isAccepted = await getIsNotificationAccepted();
    if (isAccepted == true) {
      notificationService.initializeNotificationHandlers(ref, characterColors);
    }
  }

  @override
  void initState() {
    super.initState();
    onelinkService.appsFlyerInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onelinkService.appsflyerSdk!.onDeepLinking((DeepLinkResult dp) {
        if (dp.status == Status.FOUND) {
          ref.read(deepLinkProvider.notifier).state = dp.deepLink;
          if (dp.deepLink?.deepLinkValue == null ||
              dp.deepLink?.deepLinkValue == '') return;
          context.go(//ToDo 로그인이 필요한 작업시에 characterTheme을 설정해줘야 함
              '${dp.deepLink?.deepLinkValue}'); //ToDo 딥링크로 이동하기 위해서는 비동기 함수 처리를 해야함.
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
