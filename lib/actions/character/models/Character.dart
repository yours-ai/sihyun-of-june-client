import 'package:json_annotation/json_annotation.dart';

part 'Character.g.dart';

@JsonSerializable()
class Character {
  int id;
  bool is_active;
  bool? is_blurred;
  String? name;
  int? age;
  String? MBTI;
  String? description;
  String image;

  Character(
      {required this.id,
      required this.is_active,
      required this.is_blurred,
      required this.name,
      required this.age,
      required this.MBTI,
      required this.description,
      required this.image});

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
