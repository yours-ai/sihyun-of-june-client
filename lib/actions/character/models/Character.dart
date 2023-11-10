import 'package:json_annotation/json_annotation.dart';

part 'Character.g.dart';

@JsonSerializable()
class Character {
  int id;
  bool is_active;
  bool? is_blurred;
  String? name;
  int? age;
  String? one_line_description;
  String? description;
  String default_image;
  List<String>? images;

  Character({
    required this.id,
    required this.is_active,
    required this.is_blurred,
    required this.name,
    required this.age,
    required this.one_line_description,
    required this.description,
    required this.default_image,
    required this.images,
  });

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
