import 'dart:async';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final initializeMailListProvider = StateProvider<VoidCallback?>((ref) {
  return null;
});

final selectedPageToRefetch = StateProvider<int?>((ref) {
  return null;
});
