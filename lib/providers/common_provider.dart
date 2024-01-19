import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final imageCacheDurationProvider = Provider<Duration>((ref) {
  return const Duration(days: 1);
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

final isFirstInstallProvider = StateProvider<bool>((ref) {
  return false;
});
