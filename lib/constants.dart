import 'package:flutter/material.dart';

abstract final class ColorConstants {
  static Color primary = const Color(0xff615B56);
  static Color background = const Color(0xffFBFBFB);
  static Color lightPink = const Color(0xffffafbe);
  static Color gray = const Color(0xff827B7B);
  static Color pink = const Color(0xffFF5574);
  static Color neutral = const Color(0xffc0bebb);
  static Color alert = const Color.fromRGBO(254, 49, 64, 1);
  static Color veryLightGray = const Color(0xffebebeb);
  static Color lightGray = const Color(0xffF6F6F6);
  static Color white = const Color(0xfffbfbfb);
  static Color black = const Color(0xff1a1a1a);
}

abstract final class AppID {
  static String ios = '6463772803';
  static String android = 'team.pygmalion.project_june_client';
}

abstract final class TabRoutePaths {
  static String mailList = '/mails';
  static String notificationList = '/notifications';
  static String all = '/all';
}

abstract final class Urls {
  static String notice = "https://pygmalion.app/notices/";
  static String faq =
      "https://pygmalion.app/sihyun-of-june/%EB%A5%98%EC%8B%9C%ED%98%84#faq";
  static String privacy = "https://pygmalion.app/policy/privacy";
  static String terms = "https://pygmalion.app/policy/terms";
  static String ask = "https://pf.kakao.com/_YYxoqG/chat";
  static String appstore =
      'https://apps.apple.com/kr/app/%EC%9C%A0%EC%9B%94%EC%9D%98-%EC%8B%9C%ED%98%84%EC%9D%B4/id6463772803';
  static String appleWithdraw = 'https://support.apple.com/ko-kr/HT210426';
}

abstract final class ProjectConstants {
  static TimeOfDay mailReceiveTime = const TimeOfDay(hour: 21, minute: 0);
  static TimeOfDay mailSendDueTime = const TimeOfDay(hour: 9, minute: 0);
}

abstract final class FontWeightConstants {
  static FontWeight semiBold = FontWeight.w600;
}
