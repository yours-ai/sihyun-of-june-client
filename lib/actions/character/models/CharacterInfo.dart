import 'package:json_annotation/json_annotation.dart';

part 'CharacterInfo.g.dart';

@JsonSerializable()
class CharacterInfo {
  num age;
  String? one_line_description;
  String description;
  List<String>? images;

  CharacterInfo({required this.age, this.one_line_description, required this.description, this.images});

  factory CharacterInfo.fromJson(Map<String, dynamic> json) => _$CharacterInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterInfoToJson(this);
}