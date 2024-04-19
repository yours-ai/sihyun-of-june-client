import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_cinematic.freezed.dart';

part 'character_cinematic.g.dart';

@freezed
class CharacterCinematic with _$CharacterCinematic {
  factory CharacterCinematic({
    required String cinematic_background_image_1,
    required String cinematic_background_image_2,
    required List<String> cinematic_description,
  }) = _CharacterCinematic;

  factory CharacterCinematic.fromJson(Map<String, dynamic> json) =>
      _$CharacterCinematicFromJson(json);
}
