import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/actions.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/actions/client.dart';
import 'package:project_june_client/actions/notification/queries.dart';
import 'package:project_june_client/constants.dart';
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
    initServerErrorSnackbar();
    final isLogined = await loadIsLogined();
    FlutterNativeSplash.remove();

    await _checkAppAvailability();
    await _checkUpdateAvailable();

    if (isLogined == false) {
      context.go(RoutePaths.landing);
      return;
    }

    _setUserInfoForSentry();
    await _requestAppTracking();

    await _initializeCharacterInfo();
    _checkNotificationPermission();
    _redirectIfClickedPush();
  }

  Future<void> _redirectIfClickedPush() async {
    final push = await notificationService.getPushIfPushClicked();
    if (push != null) {
      notificationService.handleFCMMessageTap(push);
    }
  }

  Future<void> _checkAppAvailability() async {
    FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 30),
        minimumFetchInterval: const Duration(minutes: 1),
      ),
    );
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
    final isNewUserRawData = await fetchIsNewUserQuery().result;
    final isNewUser = isNewUserRawData.data!['is_available'];
    if (isNewUser) {
      context.go(RoutePaths.newUserAssignmentStarting);
    } else {
      try {
        await characterService.resetProviderOfCharacter(ref);
        context.go(RoutePaths.home);
      } catch (error, stackTrace) {
        Sentry.captureException(error, stackTrace: stackTrace);
      }
    }
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
