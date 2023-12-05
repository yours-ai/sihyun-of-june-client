import 'package:json_annotation/json_annotation.dart';

part 'CharacterColors.g.dart';

@JsonSerializable()
class CharacterColors {
  int? primary;
  int? secondary;
  int? inverse_primary;
  int? inverse_on_surface;
  int? inverse_surface;

  CharacterColors(
      {this.primary,
      this.secondary,
      this.inverse_primary,
      this.inverse_on_surface,
      this.inverse_surface});

  factory CharacterColors.fromJson(Map<String, dynamic> json) =>
      _$CharacterColorsFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterColorsToJson(this);
}
