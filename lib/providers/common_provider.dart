import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final topPaddingProvider = StateProvider<double?>((ref) => null);

final firebaseMessagingListenerProvider =
    StateProvider<Map<String, StreamSubscription<dynamic>?>>((ref) {
  return {
    'onTokenRefresh': null,
    'onMessage': null,
    'onMessageOpenedApp': null,
  };
});
