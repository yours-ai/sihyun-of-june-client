import 'dart:async';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:project_june_client/actions/notification/actions.dart';
import 'package:project_june_client/actions/notification/models/AppNotification.dart';
import 'package:project_june_client/actions/notification/queries.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

import '../router.dart';


class NotificationService {
  const NotificationService();

  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();

    if (message.notification != null) {
      handleNewNotification();
    }
  }


  void handleClickNotification(AppNotification notification) {
    router.go(notification.link ?? '/mails');
    final mutation = Mutation(
      queryFn: (int id) => readNotification(id),
      refetchQueries: ["list-app-notifications"],
    );
    mutation.mutate(notification.id);
  }

  void handleNewNotification() {
    CachedQuery.instance.refetchQueries(keys: ["list-app-notifications"]);
  }

  void handleFCMMessageTap(RemoteMessage remoteMessage) {
    router.push("/notifications");
  }

  void initializeNotificationHandlers() {
    FirebaseMessaging.instance
        .getToken()
        .then((token) => token != null ? getOrCreateUserDevice(token) : null);
    FirebaseMessaging.instance.onTokenRefresh
        .listen((token) => getOrCreateUserDevice(token));
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        handleNewNotification();
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen(handleFCMMessageTap);
    addBadgeControlListener();
  }

  Future<StreamSubscription<QueryState<List<AppNotification>>>>
      addBadgeControlListener() async {
    final supported = await FlutterAppBadger.isAppBadgeSupported();
    final query = getListAppNotificationQuery();
    return query.stream.listen((state) {
      if (state.data == null) {
        return;
      }
      if (supported == true) {
        FlutterAppBadger.updateBadgeCount(state.data!
            .where((notification) => notification.is_read == false)
            .length);
      }
    });
  }
}
