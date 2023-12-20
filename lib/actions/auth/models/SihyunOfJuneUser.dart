import 'package:json_annotation/json_annotation.dart';

part 'SihyunOfJuneUser.g.dart';

@JsonSerializable()
class SihyunOfJuneUser {
  int id;
  String? phone;
  String last_name;
  String first_name;
  bool is_active;
  bool is_activable;
  int coin;
  int point;
  String env;
  String? image;
  bool is_30days_finished;

  SihyunOfJuneUser({
    required this.id,
    this.phone,
    required this.last_name,
    required this.first_name,
    required this.is_active,
    required this.is_activable,
    required this.coin,
    required this.point,
    required this.env,
    this.image,
    required this.is_30days_finished,
  });

  factory SihyunOfJuneUser.fromJson(Map<String, dynamic> json) =>
      _$SihyunOfJuneUserFromJson(json);

  Map<String, dynamic> toJson() => _$SihyunOfJuneUserToJson(this);
}
