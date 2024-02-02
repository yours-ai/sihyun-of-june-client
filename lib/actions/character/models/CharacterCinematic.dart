import 'package:json_annotation/json_annotation.dart';

part 'CharacterCinematic.g.dart';

@JsonSerializable()
class CharacterCinematic {
  String cinematic_background_image_1;
  String cinematic_background_image_2;
  List<String> cinematic_description;

  CharacterCinematic({
    required this.cinematic_background_image_1,
    required this.cinematic_background_image_2,
    required this.cinematic_description,
  });

  factory CharacterCinematic.fromJson(Map<String, dynamic> json) =>
      _$CharacterCinematicFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterCinematicToJson(this);
}
