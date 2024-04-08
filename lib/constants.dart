import 'package:flutter/material.dart';

import 'actions/character/models/CharacterColors.dart';
import 'actions/character/models/CharacterTheme.dart';

abstract final class ColorConstants {
  static Color primary = const Color(0xff615B56);
  static Color background = const Color(0xffFBFBFB);
  static Color lightPink = const Color(0xffffafbe);
  static Color gray = const Color(0xff827B7B);
  static Color pink = const Color(0xffFF5574);
  static Color neutral = const Color(0xffc0bebb);
  static Color alert = const Color.fromRGBO(254, 49, 64, 1);
  static Color veryLightGray = const Color(0xffF6F6F6);
  static Color lightGray = const Color(0xffe1e1e1);
  static Color mediumGray = const Color(0xffA7A1A1);
  static Color darkGray = const Color(0xff101010);
  static Color black = const Color(0xff1a1a1a);
}

abstract final class CachingDuration {
  static Duration image = const Duration(days: 1);
  static Duration character = const Duration(days: 1);
  static Duration assignment = Duration.zero;
}

abstract final class ColorTheme {
  static CharacterTheme defaultTheme = CharacterTheme(
    colors: CharacterColors(
      primary: 4294923379,
      secondary: 4294932624,
      inverse_primary: 4294947513,
      inverse_surface: 4281741103,
      inverse_on_surface: 4294700782,
    ),
    font: 'NanumNoRyeogHaNeunDongHee',
  );
}

abstract final class AppID {
  static String ios = '6463772803';
  static String android = 'team.pygmalion.project_june_client';
}

abstract final class RoutePaths {
  static String starting = '/';
  static String landing = '/landing';
  static String login = '/login';
  static String loginByPhone = '$login/${SubRoutePaths.byPhone}';
  static String home = '/home';
  static String homeMyCharacter = '$home/${SubRoutePaths.myCharacter}';
  static String homeDecideAssignmentMethod =
      '$home/${SubRoutePaths.decideAssignmentMethod}';
  static String between = '/between';
  static String betweenRelationship = '$between/${SubRoutePaths.relationship}';
  static String mailList = '/mails';
  static String mailListMailDetail = '$mailList/${SubRoutePaths.mailDetail}';
  static String notificationList = '/notifications';
  static String all = '/all';
  static String allMyPoint = '$all/${SubRoutePaths.myPoint}';
  static String allMyPointLog =
      '$all/${SubRoutePaths.myPoint}/${SubRoutePaths.pointLog}';
  static String allMyPointCharge =
      '$all/${SubRoutePaths.myPoint}/${SubRoutePaths.pointCharge}';
  static String allMyCoin = '$all/${SubRoutePaths.myCoin}';
  static String allMyCoinLog =
      '$all/${SubRoutePaths.myCoin}/${SubRoutePaths.coinLog}';
  static String allMyCoinCharge =
      '$all/${SubRoutePaths.myCoin}/${SubRoutePaths.coinCharge}';
  static String allShare = '$all/${SubRoutePaths.share}';
  static String allChangeName = '$all/${SubRoutePaths.changeName}';
  static String allWithdraw = '$all/${SubRoutePaths.withdraw}';
  static String allPolicy = '$all/${SubRoutePaths.policy}';
  static String characterTest = '/character-test';
  static String testDeciding = '/character-test-deciding';
  static String testConfirm = '/character-test-confirm';
  static String selectionDeciding = '/character-selection-deciding';
  static String selectionConfirm = '/character-selection-confirm';
  static String assignment = '/assignment';
  static String newUserAssignmentStarting = '/new-user-assignment-starting';
  static String retest = '/retest';
  static String retestExtend = '$retest/${SubRoutePaths.extend}';
  static String retestConfirm = '$retest/${SubRoutePaths.confirm}';
}

abstract final class SubRoutePaths {
  static String myCharacter = 'my-character';
  static String mailDetail = 'detail';
  static String myPoint = 'my-point';
  static String pointLog = 'point-log';
  static String pointCharge = 'point-charge';
  static String myCoin = 'my-coin';
  static String coinLog = 'coin-log';
  static String coinCharge = 'coin-charge';
  static String share = 'share';
  static String changeName = 'change-name';
  static String withdraw = 'withdraw';
  static String policy = 'policy';
  static String byPhone = 'by-phone';
  static String decideAssignmentMethod = 'decide-assignment-method';
  static String extend = 'extend';
  static String confirm = 'confirm';
  static String relationship = 'relationship';
}

abstract final class Urls {
  static String notice = 'https://pygmalion.app/notices/';
  static String faq = 'https://pygmalion.app/faq';
  static String privacy = 'https://pygmalion.app/policy/privacy';
  static String terms = 'https://pygmalion.app/policy/terms';
  static String ask = 'https://pf.kakao.com/_YYxoqG/chat';
  static String appstore =
      'https://apps.apple.com/kr/app/%EC%9C%A0%EC%9B%94%EC%9D%98-%EC%8B%9C%ED%98%84%EC%9D%B4/id6463772803';
  static String googlePlay =
      'https://play.google.com/store/apps/details?id=team.pygmalion.project_june_client';
  static String appleWithdraw = 'https://support.apple.com/ko-kr/HT210426';
}

abstract final class ProjectConstants {
  static TimeOfDay mailReceiveTime = const TimeOfDay(hour: 21, minute: 0);
  static TimeOfDay mailSendDueTime = const TimeOfDay(hour: 9, minute: 0);
}

abstract final class FontWeightConstants {
  static FontWeight semiBold = FontWeight.w600;
}
