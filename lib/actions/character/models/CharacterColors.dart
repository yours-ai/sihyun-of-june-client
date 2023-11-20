import 'package:json_annotation/json_annotation.dart';

part 'CharacterColors.g.dart';

@JsonSerializable()
class CharacterColors {
  int? primary;
  int? secondary;

  CharacterColors({this.primary, this.secondary});

  factory CharacterColors.fromJson(Map<String, dynamic> json) =>
      _$CharacterColorsFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterColorsToJson(this);
}