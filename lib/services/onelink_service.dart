import 'dart:io';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/environments.dart';

class OnelinkService {
  AppsflyerSdk? appsflyerSdk;

  Future<void> appsFlyerInit() async {
    AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
      afDevKey: BuildTimeEnvironments.appsFlyerKey,
      appId:
          Platform.isIOS ? AppID.ios : AppID.android,
      showDebug: false,
    );
    appsflyerSdk = AppsflyerSdk(appsFlyerOptions);
    await appsflyerSdk!.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
    );
  }
}
