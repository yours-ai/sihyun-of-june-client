import 'package:json_annotation/json_annotation.dart';
import 'package:project_june_client/actions/character/models/CharacterInfo.dart';
import 'package:project_june_client/actions/character/models/CharacterTheme.dart';

part 'Character.g.dart';

@JsonSerializable()
class Character {
  int id;
  bool is_active;
  String? name;
  CharacterInfo? character_info;
  CharacterTheme? theme;
  bool? is_image_updated;
  DateTime? date_allocated;

  Character({
    required this.id,
    required this.is_active,
    required this.name,
    required this.character_info,
    required this.theme,
    this.is_image_updated,
    this.date_allocated,
  });

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
