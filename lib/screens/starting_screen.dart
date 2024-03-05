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
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/providers/user_provider.dart';
import 'package:project_june_client/services.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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

    await _requestAppTracking();
    await _checkAppAvailability();
    await _checkUpdateAvailable();
    if (!mounted) return;
    initServerErrorSnackbar(context);

    if (isLogined == false) {
      if (!mounted) return;
      context.go(RoutePaths.landing);
      return;
    }

    _setUserInfoForSentry();
    await _initializeCharacterInfo();
    notificationService.initializeNotificationHandlers(ref);
    final push = await getPushIfPushClicked();
    if (push != null) {
      notificationService.handleFCMMessageTap(push);
      return;
    }
  }

  Future<void> _setUserInfoForSentry() async {
    final userInfoRawData = await fetchMeQuery().result;
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

  Future<void> _checkAppAvailability() async {
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

  Future<void> _checkUpdateAvailable() async {
    if (Platform.isAndroid) {
      updateService.checkAndUpdateAndroidApp();
    }

    if (Platform.isIOS) {
      await updateService.checkAndUpdateIOSApp(context);
    }
  }

  Future<void> _requestAppTracking() async {
    final TrackingStatus status =
        await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }

  Future<void> _initializeCharacterInfo() async {
    final myCharacters = await fetchMyCharacterQuery().result;
    final hasCharacter =
        myCharacters.data != null && myCharacters.data!.isNotEmpty;
    await _checkEnableToRetest(hasCharacter, myCharacters.data);
    if (hasCharacter) {
      await _saveSelectedCharacterId(myCharacters.data!);
      await _setSelectedCharacterTheme(myCharacters.data!);
      if (!mounted) return;
      context.go(RoutePaths.mailList);
    } else {
      final isNewUserRawData = await fetchIsNewUserQuery().result;
      final isNewUser = isNewUserRawData.data!['is_available'];
      if (isNewUser) {
        if (!mounted) return;
        context.go(RoutePaths.newUserAssignmentStarting);
      } else {
        if (!mounted) return;
        context.go(RoutePaths.mailList);
      }
    }
  }

  Future<void> _saveSelectedCharacterId(List<Character> myCharacters) async {
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
      final selectedCharacterTheme = selectedCharacterList.first.theme;
      ref.read(characterThemeProvider.notifier).state = selectedCharacterTheme;
    }
  }

  Future<void> _checkEnableToRetest(
      bool hasCharacter, List<Character>? myCharacters) async {
    if (hasCharacter == false || myCharacters == null || myCharacters.isEmpty) {
      ref.read(isEnableToRetestProvider.notifier).state = true;
      return;
    }
    final allCharacters = await fetchAllCharactersQuery().result;
    final isEnableToRetest = myCharacters.length != allCharacters.data!.length;
    ref.read(isEnableToRetestProvider.notifier).state = isEnableToRetest;
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
