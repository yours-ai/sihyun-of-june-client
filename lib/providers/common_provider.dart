import 'package:flutter/animation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final topPaddingProvider = StateProvider<double?>((ref) => null);

final animationControllersProvider =
    StateProvider.autoDispose<List<AnimationController>>((ref) => []);
