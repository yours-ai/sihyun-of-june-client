import 'package:json_annotation/json_annotation.dart';
import 'package:project_june_client/actions/character/models/CharacterColors.dart';

part 'CharacterTheme.g.dart';

@JsonSerializable()
class CharacterTheme {
  CharacterColors? colors;
  String? font;

  CharacterTheme({this.colors, this.font});

  factory CharacterTheme.fromJson(Map<String, dynamic> json) =>
      _$CharacterThemeFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterThemeToJson(this);
}
