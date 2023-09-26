// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SihyunOfJuneUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SihyunOfJuneUser _$SihyunOfJuneUserFromJson(Map<String, dynamic> json) =>
    SihyunOfJuneUser(
      id: json['id'] as num,
      phone: json['phone'] as String?,
      last_name: json['last_name'] as String,
      first_name: json['first_name'] as String,
      is_active: json['is_active'] as bool,
      is_activable: json['is_activable'] as bool,
    );

Map<String, dynamic> _$SihyunOfJuneUserToJson(SihyunOfJuneUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'last_name': instance.last_name,
      'first_name': instance.first_name,
      'is_active': instance.is_active,
      'is_activable': instance.is_activable,
    };
