// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserDevice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDevice _$UserDeviceFromJson(Map<String, dynamic> json) => UserDevice(
      pk: json['pk'] as num,
      user: json['user'] as num,
      device_token: json['device_token'] as String,
    );

Map<String, dynamic> _$UserDeviceToJson(UserDevice instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'user': instance.user,
      'device_token': instance.device_token,
    };
