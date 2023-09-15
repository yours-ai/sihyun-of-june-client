import 'package:json_annotation/json_annotation.dart';

part 'SihyunOfJuneUser.g.dart';

@JsonSerializable()
class SihyunOfJuneUser {
  num id;
  String? phone;
  String last_name;
  String first_name;
  bool is_active;
  bool is_activable;

  SihyunOfJuneUser({
    required this.id,
    this.phone,
    required this.last_name,
    required this.first_name,
    required this.is_active,
    required this.is_activable,
  });

  factory SihyunOfJuneUser.fromJson(Map<String, dynamic> json) =>
      _$SihyunOfJuneUserFromJson(json);

  Map<String, dynamic> toJson() => _$SihyunOfJuneUserToJson(this);
}