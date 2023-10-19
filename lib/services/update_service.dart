import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';

class UpdateService {
  const UpdateService();

  Future<String> getCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<String> getLatestVersion() async {
    FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();
    return Platform.isIOS
        ? remoteConfig.getString('ios_version')
        : remoteConfig.getString('android_version');
  }

  Future<String> isUpdateRequired() async {
    // final currentVersion = Version.parse(await getCurrentVersion());
    // final latestVersion = Version.parse(await getLatestVersion());
    // if(latestVersion.major > currentVersion.major){
    //   return "required";
    // }
    // else if(latestVersion.minor > currentVersion.minor){
    //   return "required";
    // }
    // else if(latestVersion.patch > currentVersion.patch){
    //   return "optional";
    // }
    // else{
    //   return "none";
    // }
    return 'required';
  }
}
