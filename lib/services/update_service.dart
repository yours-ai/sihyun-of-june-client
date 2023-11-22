import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
    await showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext context) => UpdateWidget(
        releaseNotes: remoteConfig.getString('release_notes'),
        isForceUpdate: true,
      ),
    );
  }
}
