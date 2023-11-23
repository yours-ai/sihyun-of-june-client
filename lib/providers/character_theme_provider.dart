import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/character/models/CharacterColors.dart';
import 'package:project_june_client/actions/character/models/CharacterTheme.dart';

final characterThemeProvider = StateProvider.autoDispose<CharacterTheme>((ref) {
  final CharacterTheme defaultTheme = CharacterTheme(
    colors: CharacterColors(primary: 4294923379, secondary: 4294932624),
    font: "NanumNoRyeogHaNeunDongHee",
  );
  return defaultTheme;
});
