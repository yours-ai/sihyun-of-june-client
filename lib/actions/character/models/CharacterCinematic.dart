import 'package:json_annotation/json_annotation.dart';
import 'package:project_june_client/actions/character/models/CinematicBackground.dart';

part 'CharacterCinematic.g.dart';

@JsonSerializable()
class CharacterCinematic {
  CinematicBackground background;
  List<String> text;

  CharacterCinematic({
    required this.background,
    required this.text,
  });

  factory CharacterCinematic.fromJson(Map<String, dynamic> json) =>
      _$CharacterCinematicFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterCinematicToJson(this);
}
