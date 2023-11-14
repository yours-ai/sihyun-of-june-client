import 'package:json_annotation/json_annotation.dart';
import 'package:project_june_client/actions/character/models/CharacterInfo.dart';
import 'package:project_june_client/actions/character/models/CharacterTheme.dart';

part 'Character.g.dart';

@JsonSerializable()
class Character {
  num id;
  bool is_active;
  String? name;
  String default_image;
  bool? is_blurred;
  CharacterInfo? character_info;
  CharacterTheme? theme;

  Character({required this.id, required this.is_active, required this.name, required this.default_image, this.is_blurred, required this.character_info, required this.theme});

  factory Character.fromJson(Map<String, dynamic> json) => _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
