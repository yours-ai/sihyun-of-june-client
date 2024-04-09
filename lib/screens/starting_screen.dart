import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/actions.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/actions/character/models/Character.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/actions/client.dart';
import 'package:project_june_client/actions/notification/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/contrib/flutter_secure_storage.dart';
import 'package:project_june_client/providers/character_provider.dart';
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
    await _checkNotificationPermission();
    final push = await notificationService.getPushIfPushClicked();
    if (push != null) {
      notificationService.handleFCMMessageTap(push);
      return;
    }
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
    final storage = getSecureStorage();
    final isNewUserRawData = await fetchIsNewUserQuery().result;
    final isNewUser = isNewUserRawData.data!['is_available'];
    if (isNewUser) {
      if (!mounted) return;
      context.go(RoutePaths.newUserAssignmentStarting);
    } else {
      final isSaved = await _checkIsCharacterSaved(storage);
      if (!isSaved) {
        final myCharacters = await fetchMyCharacterQuery().result;
        final hasCharacter =
            myCharacters.data != null && myCharacters.data!.isNotEmpty;
        if (hasCharacter) {
          await _saveInitialSelectedCharacter(
              storage, myCharacters.data!.first);
        }
      }
      if (!mounted) return;
      context.go(RoutePaths.home);
    }
  }

  Future<bool> _checkIsCharacterSaved(FlutterSecureStorage storage) async {
    final selectedCharacterId =
        await storage.read(key: StorageKeyConstants.characterId);
    final selectedAssignId =
        await storage.read(key: StorageKeyConstants.assignId);
    if (selectedCharacterId == null || selectedAssignId == null) {
      return false;
    }
    final characterId = int.parse(selectedCharacterId);
    final selectedCharacterRawData =
        await fetchCharacterByIdQuery(id: characterId).result;
    if (selectedCharacterRawData.error != null) {
      Sentry.captureException(selectedCharacterRawData.error!);
      return false;
    }
    final selectedCharacterTheme = selectedCharacterRawData.data!.theme;
    ref.read(characterThemeProvider.notifier).state = selectedCharacterTheme;
    ref.read(selectedCharacterProvider.notifier).state = characterId;
    ref.read(selectedAssignProvider.notifier).state =
        int.parse(selectedAssignId);
    return true;
  }

  Future<void> _saveInitialSelectedCharacter(
      FlutterSecureStorage storage, Character myCharacter) async {
    final characterId = myCharacter.id;
    ref.read(selectedCharacterProvider.notifier).state = characterId;
    ref.read(selectedAssignProvider.notifier).state =
        myCharacter.assigned_characters!.last.assigned_character_id;
    await storage.write(
        key: StorageKeyConstants.characterId, value: characterId.toString());
    await storage.write(
        key: StorageKeyConstants.assignId,
        value: myCharacter.assigned_characters!.last.assigned_character_id
            .toString());
    ref.read(characterThemeProvider.notifier).state = myCharacter.theme;
  }

  Future<void> _checkNotificationPermission() async {
    final isNotificationAccepted =
        await fetchIsNotificationAcceptedQuery().result;
    if (isNotificationAccepted.data == true) {
      notificationService.initializeNotificationHandlers();
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
