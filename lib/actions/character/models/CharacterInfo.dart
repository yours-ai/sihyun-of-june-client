import 'package:json_annotation/json_annotation.dart';
import 'package:project_june_client/actions/character/models/CharacterImage.dart';

part 'CharacterInfo.g.dart';

@JsonSerializable()
class CharacterInfo {
  num? age;
  String? one_line_description;
  String? description;
  List<CharacterImage>? images;

  CharacterInfo(
      {this.age, this.one_line_description, this.description, this.images});

  factory CharacterInfo.fromJson(Map<String, dynamic> json) =>
      _$CharacterInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterInfoToJson(this);
}
