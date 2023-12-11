import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final imageCacheDurationProvider = Provider<Duration>((ref) {
  return const Duration(minutes: 50);
});

final topPaddingProvider = StateProvider<double?>((ref) => null);

final firebaseMessagingListenerProvider =
    StateProvider<Map<String, StreamSubscription<dynamic>?>>((ref) {
  return {
    'onTokenRefresh': null,
    'onMessage': null,
    'onMessageOpenedApp': null,
  };
});
