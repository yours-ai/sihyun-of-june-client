import 'package:flutter_riverpod/flutter_riverpod.dart';

final imageCacheDurationProvider = Provider<Duration>((ref) {
  return const Duration(minutes: 50);
});

final topPaddingProvider = StateProvider<double?>((ref) => null);