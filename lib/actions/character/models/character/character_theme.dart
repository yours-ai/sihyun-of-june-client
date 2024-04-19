import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:project_june_client/actions/character/models/character/character_colors.dart';

part 'character_theme.freezed.dart';

part 'character_theme.g.dart';

@freezed
class CharacterTheme with _$CharacterTheme {
  factory CharacterTheme({
    required CharacterColors colors,
    required String font,
  }) = _CharacterTheme;

  factory CharacterTheme.fromJson(Map<String, dynamic> json) =>
      _$CharacterThemeFromJson(json);
}
