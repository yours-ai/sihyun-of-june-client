import 'package:firebase_messaging/firebase_messaging.dart';

import '../client.dart';
import 'models/UserDevice.dart';

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

Future<void> getOrCreateUserDevice(String token) async {
  final List<UserDevice> userDevices = await dio
      .get('/notification/user-devices/')
      .then((response) => response.data
          .map<UserDevice>((json) => UserDevice.fromJson(json))
          .toList());
  // if token not exists on userDevices, create new one
  if (userDevices
      .where((userDevice) => userDevice.device_token == token)
      .toList()
      .isEmpty) {
    await dio.post('/notification/user-devices/', data: {
      'device_token': token,
    });
  }
}