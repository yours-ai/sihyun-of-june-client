import 'dart:ui';

abstract final class ColorConstants {
  static Color primary = const Color(0xff1a1a1a);
  static Color background = const Color(0xfff6f6f6);
  static Color secondary = const Color.fromRGBO(68, 68, 68, 0.9);
  static Color alert = const Color.fromRGBO(254, 49, 64, 1);
  static Color light = const Color(0xffcacaca);
  static Color veryLight = const Color(0xffdedede);
  static Color neutral = const Color(0xff9a9a9a);

  static Color white = const Color(0xfffcfcfc);
  static Color black = const Color(0xff1a1a1a);
}

abstract final class TabRoutePaths {
  static String mailList = '/mails';
  static String notificationList = '/notifications';
  static String all = '/all';
}

abstract final class Urls {
  static String notice = "https://pygmalion.app/notices/";
  static String faq = "https://pygmalion.app/sihyun-of-june/%EB%A5%98%EC%8B%9C%ED%98%84#faq";
  static String privacy = "https://pygmalion.app/policy/privacy";
  static String terms = "https://pygmalion.app/policy/terms";
  static String ask = "https://pf.kakao.com/_YYxoqG/chat";
}