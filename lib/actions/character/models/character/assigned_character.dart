import 'package:freezed_annotation/freezed_annotation.dart';

part 'assigned_character.freezed.dart';

part 'assigned_character.g.dart';

@freezed
class AssignedCharacter with _$AssignedCharacter {
  factory AssignedCharacter({
    required int assigned_character_id,
    required DateTime first_mail_available_at,
    required bool is_active,
  }) = _AssignedCharacter;

  factory AssignedCharacter.fromJson(Map<String, dynamic> json) =>
      _$AssignedCharacterFromJson(json);
}
