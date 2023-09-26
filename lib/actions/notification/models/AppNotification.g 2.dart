// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppNotification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) =>
    AppNotification(
      id: json['id'] as int,
      created: DateTime.parse(json['created'] as String),
      modified: DateTime.parse(json['modified'] as String),
      title: json['title'] as String,
      body: json['body'] as String,
      link: json['link'] as String?,
      is_read: json['is_read'] as bool?,
      is_all: json['is_all'] as bool,
      user: json['user'] as num,
    );

Map<String, dynamic> _$AppNotificationToJson(AppNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created': instance.created.toIso8601String(),
      'modified': instance.modified.toIso8601String(),
      'title': instance.title,
      'body': instance.body,
      'link': instance.link,
      'is_read': instance.is_read,
      'is_all': instance.is_all,
      'user': instance.user,
    };
