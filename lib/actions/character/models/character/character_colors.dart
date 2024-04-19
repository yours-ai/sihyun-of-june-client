import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_colors.freezed.dart';

part 'character_colors.g.dart';

@freezed
class CharacterColors with _$CharacterColors {
  factory CharacterColors({
    required int primary,
    required int secondary,
    required int inverse_primary,
    required int inverse_on_surface,
    required int inverse_surface,
  }) = _CharacterColors;

  factory CharacterColors.fromJson(Map<String, dynamic> json) =>
      _$CharacterColorsFromJson(json);
}
