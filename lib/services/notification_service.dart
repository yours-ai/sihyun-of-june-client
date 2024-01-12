import 'dart:async';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:project_june_client/actions/character/models/CharacterColors.dart';
import 'package:project_june_client/actions/notification/actions.dart';
import 'package:project_june_client/actions/notification/models/AppNotification.dart';
import 'package:project_june_client/actions/notification/queries.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:project_june_client/globals.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/providers/common_provider.dart';
import 'package:project_june_client/widgets/common/create_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../router.dart';
import '../services.dart';

class NotificationService {
  const NotificationService();

  void routeRedirectLink(String? redirectLink) {
    if (redirectLink != null && redirectLink.isNotEmpty) {
      if (redirectLink.length > 4 && redirectLink.substring(0, 4) == 'http') {
        launchUrl(Uri.parse(redirectLink));
      } else {
        router.push(redirectLink);
      }
    }
  }

  void handleClickNotification(String? redirectLink, int notificationId) {
    final mutation = readNotificationMutation(
      onSuccess: (res, arg) => routeRedirectLink(redirectLink),
      refetchQueries: ["list-app-notifications"],
    );
    mutation.mutate(notificationId);
  }

  void handleNewNotification() {
    CachedQuery.instance.refetchQueries(keys: ["list-app-notifications"]);
  }

  void handleFCMMessageTap(RemoteMessage remoteMessage) async {
    // 앱 열릴때 실행되는 함수
    String? redirectLink = await remoteMessage.data['link'];
    int? notificationId = int.tryParse(remoteMessage.data['id'] ?? '');
    // id의 유무는 전체에게 보내면 id가 없고, 개인에게 보내면 id가 있음.
    if (notificationId == null || notificationId.isNaN) {
      router.go("/notifications", extra: redirectLink);
      return;
    } else {
      final mutation = readNotificationMutation(
        onSuccess: (res, arg) {
          router.go("/notifications", extra: redirectLink);
        },
      );
      mutation.mutate(notificationId);
    }
  }

  void initializeNotificationHandlers(
      WidgetRef ref) async {
    if (ref.read(firebaseMessagingListenerProvider)['onTokenRefresh'] != null &&
        ref.read(firebaseMessagingListenerProvider)['onMessage'] != null &&
        ref.read(firebaseMessagingListenerProvider)['onMessageOpenedApp'] !=
            null) {
      await ref
          .read(firebaseMessagingListenerProvider)['onTokenRefresh']!
          .cancel();
      await ref.read(firebaseMessagingListenerProvider)['onMessage']!.cancel();
      await ref
          .read(firebaseMessagingListenerProvider)['onMessageOpenedApp']!
          .cancel();
    }
    FirebaseMessaging.instance
        .getToken()
        .then((token) => token != null ? getOrCreateUserDevice(token) : null);
    ref
            .read(firebaseMessagingListenerProvider.notifier)
            .state['onTokenRefresh'] =
        FirebaseMessaging.instance.onTokenRefresh
            .listen((token) => getOrCreateUserDevice(token));
    ref.read(firebaseMessagingListenerProvider.notifier).state['onMessage'] =
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // 포그라운드
      handleNewNotification();
      String snackBarText = message.notification?.body ?? message.data['body'];
      String? redirectLink = message.data['link'];
      int? notificationId = int.tryParse(message.data['id'] ?? '');
      scaffoldMessengerKey.currentState?.showSnackBar(createSnackBar(
          snackBarText: snackBarText,
          characterColors: ref.watch(characterThemeProvider).colors!,
          onPressed: () {
            // id의 유무는 전체에게 보내면 id가 없고, 개인에게 보내면 id가 있음.
            if (notificationId == null || notificationId.isNaN) {
              router.go("/notifications", extra: redirectLink);
              return;
            } else {
              final mutation = readNotificationMutation(
                onSuccess: (res, arg) {
                  notificationService.routeRedirectLink(
                      redirectLink); // 개인한테 보냈는데, link가 있는 경우. 예) 캐릭터가 보낸 메일
                  scaffoldMessengerKey.currentState
                      ?.hideCurrentSnackBar(); // 개인한테 보냈는데, link가 없는 경우. 예) 포인트 쌓임
                },
                refetchQueries: ["list-app-notifications"],
              );
              mutation.mutate(notificationId);
            }
          }));
    });
    ref
            .read(firebaseMessagingListenerProvider.notifier)
            .state['onMessageOpenedApp'] =
        FirebaseMessaging.onMessageOpenedApp
            .listen(handleFCMMessageTap); //백그라운드 -> 포그라운드
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

  void requestAppReview() async {
    final InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }
}
