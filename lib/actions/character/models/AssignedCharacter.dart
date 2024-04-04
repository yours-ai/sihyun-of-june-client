import 'package:json_annotation/json_annotation.dart';

part 'AssignedCharacter.g.dart';

@JsonSerializable()
class AssignedCharacter {
  int assigned_character_id;
  DateTime first_mail_available_at;

  AssignedCharacter({
    required this.assigned_character_id,
    required this.first_mail_available_at,
  });

  factory AssignedCharacter.fromJson(Map<String, dynamic> json) =>
      _$AssignedCharacterFromJson(json);

  Map<String, dynamic> toJson() => _$AssignedCharacterToJson(this);
}
