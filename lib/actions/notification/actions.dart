import 'package:firebase_messaging/firebase_messaging.dart';

bool _checkIsAccepted(NotificationSettings settings) {
  return (settings.authorizationStatus == AuthorizationStatus.authorized ||
      settings.authorizationStatus == AuthorizationStatus.provisional);
}

Future<bool> getIsNotificationAccepted() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final settings = await messaging.getNotificationSettings();
  return _checkIsAccepted(settings);
}

Future<void> requestNotificationPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if (!_checkIsAccepted(settings)) {
    throw Exception("알림 동의를 받지 못했어요.");
  }
}
