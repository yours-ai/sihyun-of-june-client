import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:project_june_client/actions/character/models/character/assigned_character.dart';
import 'package:project_june_client/actions/character/models/character/character_info.dart';
import 'package:project_june_client/actions/character/models/character/character_theme.dart';

part 'character.freezed.dart';

part 'character.g.dart';

@freezed
class Character with _$Character {
  factory Character({
    required int id,
    required bool is_active,
    required String name,
    required String first_name,
    required CharacterInfo character_info,
    required CharacterTheme theme,
    bool? is_image_updated,
    List<AssignedCharacter>? assigned_characters,
  }) = _Character;

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
}
