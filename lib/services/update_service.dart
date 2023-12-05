import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:project_june_client/widgets/common/alert/alert_description_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../widgets/common/alert/alert_widget.dart';
import '../widgets/update_widget.dart';

class UpdateService {
  const UpdateService();

  Future<void> checkAndUpdateAndroidApp() async {
    try {
      final info = await InAppUpdate.checkForUpdate();
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        await InAppUpdate.startFlexibleUpdate();
        await InAppUpdate.completeFlexibleUpdate();
      }
    } catch (e) {
      (BuildContext context) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
    }
  }

  Future<void> checkAndUpdateIOSApp(BuildContext context) async {
    try {
      final newVersionPlus = NewVersionPlus(
          iOSId: 'team.pygmalion.projectJune',
          androidId: 'team.pygmalion.project_june_client');
      final status = await newVersionPlus.getVersionStatus();
      if (status != null && status.canUpdate == true) {
        await showModalBottomSheet(
            context: context,
            builder: (BuildContext context) =>
                UpdateWidget(releaseNotes: status.releaseNotes));
      }
    } catch (e) {
      (BuildContext context) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
    }
  }

  Future<void> forceUpdateByRemoteConfig(
      BuildContext context, FirebaseRemoteConfig remoteConfig) async {
    if (remoteConfig.getBool('force_update') == false) {
      return;
    }
    String latestVersion = Platform.isIOS
        ? remoteConfig.getString('ios_version')
        : remoteConfig.getString('android_version');
    PackageInfo _packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = _packageInfo.version;
    if (latestVersion == currentVersion) {
      return;
    }
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: AlertWidget(
              title: '새로운 버전이 출시되었어요!',
              content: AlertDescriptionWidget(
                description: remoteConfig.getString('release_notes'),
              ),
              confirmText: '업데이트',
              onConfirm: () {
                launchUrl(Uri.parse(
                    Platform.isIOS ? Urls.appstore : Urls.googlePlay));
              }),
        );
      },
    );
  }
}
