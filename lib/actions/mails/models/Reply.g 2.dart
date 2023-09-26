// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reply _$ReplyFromJson(Map<String, dynamic> json) => Reply(
      id: json['id'] as num,
      description: json['description'] as String,
      created: DateTime.parse(json['created'] as String),
      modified: DateTime.parse(json['modified'] as String),
    );

Map<String, dynamic> _$ReplyToJson(Reply instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'created': instance.created.toIso8601String(),
      'modified': instance.modified.toIso8601String(),
    };
