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
      final newVersionPlus = await NewVersionPlus(
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

  Future<void> forceUpdateByRemoteConfig(BuildContext context) async {
    final remoteConfig = await FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();
    // if (remoteConfig.getBool('force_update') == false) {
    //   return;
    // }
    String latestVersion = Platform.isIOS
        ? remoteConfig.getString('ios_version')
        : remoteConfig.getString('android_version');
    var _packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = _packageInfo.version;
    print('latestVersion: $latestVersion');
    print('currentVersion: $currentVersion');
    if (latestVersion == currentVersion) {
      return;
    }
    await showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext context) => UpdateWidget(
        releaseNotes: '현재버전: ' +
            currentVersion +
            '\n최신 버전: ' +
            latestVersion +
            '\n' +
            remoteConfig.getString('description'),
        isForceUpdate: true,
      ),
    );
  }
}
