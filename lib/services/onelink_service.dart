import 'dart:io';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/environments.dart';

class OnelinkService {
  AppsflyerSdk? appsflyerSdk;

  Future<void> appsFlyerInit() async {
    AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
      afDevKey: BuildTimeEnvironments.appsFlyerDevKey,
      appId: Platform.isIOS ? AppID.ios : AppID.android,
      showDebug: !BuildTimeEnvironments.isProduction,
      timeToWaitForATTUserAuthorization: 10,
    );
    appsflyerSdk ??= AppsflyerSdk(appsFlyerOptions);
    await appsflyerSdk!.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
    );
  }
}
