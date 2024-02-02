import 'package:json_annotation/json_annotation.dart';

part 'CharacterColors.g.dart';

@JsonSerializable()
class CharacterColors {
  int primary;
  int secondary;
  int inverse_primary;
  int inverse_on_surface;
  int inverse_surface;

  CharacterColors({
    required this.primary,
    required this.secondary,
    required this.inverse_primary,
    required this.inverse_on_surface,
    required this.inverse_surface,
  });

  factory CharacterColors.fromJson(Map<String, dynamic> json) =>
      _$CharacterColorsFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterColorsToJson(this);
}
