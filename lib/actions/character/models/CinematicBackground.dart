import 'package:json_annotation/json_annotation.dart';

part 'CinematicBackground.g.dart';

@JsonSerializable()
class CinematicBackground {
  String main;
  String finish;

  CinematicBackground({
    required this.main,
    required this.finish,
  });

  factory CinematicBackground.fromJson(Map<String, dynamic> json) =>
      _$CinematicBackgroundFromJson(json);

  Map<String, dynamic> toJson() => _$CinematicBackgroundToJson(this);
}
