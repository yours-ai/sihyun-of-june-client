import 'package:json_annotation/json_annotation.dart';

part 'Character.g.dart';

@JsonSerializable()
class Character {
  num id;
  String get_full_name;
  num age;
  String MBTI;
  String description;
  String profile_image;

  Character({
    required this.id,
    required this.get_full_name,
    required this.age,
    required this.MBTI,
    required this.description,
    required this.profile_image,
  });

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
