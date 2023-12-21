import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/character/models/CharacterTheme.dart';
import 'package:project_june_client/constants.dart';

final characterThemeProvider = StateProvider.autoDispose<CharacterTheme>((ref) {
  return ColorTheme.defaultTheme;
});

final selectedCharacterProvider = StateProvider<int?>((ref) => null);
