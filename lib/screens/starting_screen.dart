import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/actions.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/actions/client.dart';
import 'package:project_june_client/contrib/flutter_secure_storage.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/providers/common_provider.dart';
import 'package:project_june_client/providers/user_provider.dart';
import 'package:project_june_client/services.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../actions/notification/actions.dart';
import '../widgets/common/alert/alert_description_widget.dart';
import '../widgets/common/alert/alert_widget.dart';

const _IS_FIRST_INSTALL_KEY = 'IS_FIRST_INSTALL';

class StartingScreen extends ConsumerStatefulWidget {
  const StartingScreen({super.key});

  @override
  StartingScreenState createState() => StartingScreenState();
}

class StartingScreenState extends ConsumerState<StartingScreen> {
  _checkAuthAndLand() async {
    final isLogined = await loadIsLogined();
    FlutterNativeSplash.remove();

    await _requestAppTracking();
    await _checkAppAvailability();
    await _checkUpdateAvailable();
    await _checkFinishTutorial();
    if (!mounted) return;
    initServerErrorSnackbar(context);

    if (isLogined == false) {
      if (!mounted) return;
      context.go('/landing');
      return;
    }

    _setUserInfoForSentry();
    await _initializeCharacterInfo();
    await _initializeNotificationHandlerIfAccepted();
    final push = await getPushIfPushClicked();
    if (push != null) {
      notificationService.handleFCMMessageTap(push);
      return;
    }
  }

  _setUserInfoForSentry() async {
    final userInfoRawData = await getRetrieveMeQuery().result;
    Sentry.configureScope(
      (scope) => scope
        ..setUser(
          SentryUser(
            id: userInfoRawData.data!.id.toString(),
            username: userInfoRawData.data!.last_name +
                userInfoRawData.data!.first_name,
          ),
        ),
    );
  }

  _checkAppAvailability() async {
    FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(minutes: 1),
    ));
    await remoteConfig.fetchAndActivate();
    if (remoteConfig.getBool('app_available') == false) {
      if (!mounted) return;
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
      if (!mounted) return;
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

  _requestAppTracking() async {
    final TrackingStatus status =
        await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }

  _checkFinishTutorial() async {
    final storage = getSecureStorage();
    final String? isFirstInstall = await storage.read(key: _IS_FIRST_INSTALL_KEY);
    if(!mounted) return;
    if (isFirstInstall == null) {
      ref.read(isFirstInstallProvider.notifier).state = true;
    } else {
      ref.read(isFirstInstallProvider.notifier).state = false;
    }
  }

  _initializeCharacterInfo() async {
    final myCharacters = await getRetrieveMyCharacterQuery().result;
    final hasCharacter =
        myCharacters.data != null && myCharacters.data!.isNotEmpty;
    await _checkEnableToRetest(hasCharacter, myCharacters.data);
    if (hasCharacter) {
      await _saveSelectedCharacterId(myCharacters.data!);
      await _setSelectedCharacterTheme(myCharacters.data!);
      if (!mounted) return;
      context.go('/mails');
    } else {
      final isNewUserRawData = await getCheckNewUserQuery().result;
      final isNewUser = isNewUserRawData.data!['is_available'];
      if (isNewUser) {
        if (!mounted) return;
        context.go('/assignment');
      } else {
        if (!mounted) return;
        context.go('/mails');
      }
    }
  }

  _saveSelectedCharacterId(List<Character> myCharacters) async {
    final selectedCharacterId = await characterService.getSelectedCharacterId();
    if (selectedCharacterId == null) {
      ref.read(selectedCharacterProvider.notifier).state = myCharacters[0].id;
      await characterService.saveSelectedCharacterId(myCharacters[0].id);
    } else {
      ref.read(selectedCharacterProvider.notifier).state = selectedCharacterId;
    }
  }

  _setSelectedCharacterTheme(List<Character> myCharacters) async {
    final selectedCharacterId = await characterService.getSelectedCharacterId();
    if (selectedCharacterId != null) {
      final selectedCharacterList = myCharacters
          .where((character) => character.id == selectedCharacterId);
      if (selectedCharacterList.isEmpty) {
        logout();
        return;
      }
      final selectedCharacterTheme = selectedCharacterList.first.theme!;
      ref.read(characterThemeProvider.notifier).state = selectedCharacterTheme;
    }
  }

  _checkEnableToRetest(bool hasCharacter, List<Character>? myCharacters) async {
    if (hasCharacter == false || myCharacters == null || myCharacters.isEmpty) {
      ref.read(isEnableToRetestProvider.notifier).state = true;
      return;
    }
    final allCharacters = await getAllCharactersQuery().result;
    final isEnableToRetest = myCharacters.length != allCharacters.data!.length;
    ref.read(isEnableToRetestProvider.notifier).state = isEnableToRetest;
  }

  _initializeNotificationHandlerIfAccepted() async {
    final isAccepted = await getIsNotificationAccepted();
    if (isAccepted == true) {
      notificationService.initializeNotificationHandlers(ref);
    }
  }

  Future<RemoteMessage?> getPushIfPushClicked() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    return initialMessage;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthAndLand();
    });
  }

  @override
  Widget build(context) {
    return const Scaffold();
  }
}
