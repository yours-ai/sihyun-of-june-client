import 'dart:io';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';

class OnelinkService {
  AppsflyerSdk? appsflyerSdk;

  Future<void> appsFlyerInit() async {
    AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
      afDevKey: 'frxewKANsNPxG3KRKnqtF5',
      appId:
          Platform.isIOS ? '6463772803' : 'team.pygmalion.project_june_client',
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
