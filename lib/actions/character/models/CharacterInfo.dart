import 'package:json_annotation/json_annotation.dart';
import 'package:project_june_client/actions/character/models/CharacterImage.dart';
import 'package:project_june_client/actions/character/models/CharacterSns.dart';

part 'CharacterInfo.g.dart';

@JsonSerializable()
class CharacterInfo {
  num age;
  String one_line_description;
  String description;
  List<CharacterImage> images;
  List<CharacterSns>? sns;

  CharacterInfo({
    required this.age,
    required this.one_line_description,
    required this.description,
    required this.images,
    this.sns,
  });

  factory CharacterInfo.fromJson(Map<String, dynamic> json) =>
      _$CharacterInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterInfoToJson(this);
}
