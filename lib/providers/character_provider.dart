import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/character/models/CharacterColors.dart';
import 'package:project_june_client/actions/character/models/CharacterTheme.dart';

final characterThemeProvider = StateProvider.autoDispose<CharacterTheme>((ref) {
  final CharacterTheme defaultTheme = CharacterTheme(
    colors: CharacterColors(
        primary: 4294923379,
        secondary: 4294932624,
        inverse_primary: 4294947513,
        inverse_surface: 4281741103,
        inverse_on_surface: 4294700782),
    font: "NanumNoRyeogHaNeunDongHee",
  );
  return defaultTheme;
});

final selectedCharacterProvider = StateProvider<int?>((ref) => null);
