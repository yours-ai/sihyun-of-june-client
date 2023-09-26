// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Mail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mail _$MailFromJson(Map<String, dynamic> json) => Mail(
      id: json['id'] as int,
      to: json['to'] as num,
      to_full_name: json['to_full_name'] as String,
      by: json['by'] as num,
      by_full_name: json['by_full_name'] as String,
      by_image: json['by_image'] as String?,
      description: json['description'] as String,
      available_at: DateTime.parse(json['available_at'] as String),
      is_read: json['is_read'] as bool,
      replies: (json['replies'] as List<dynamic>?)
          ?.map((e) => Reply.fromJson(e as Map<String, dynamic>))
          .toList(),
      image: json['image'] as String?,
    );

Map<String, dynamic> _$MailToJson(Mail instance) => <String, dynamic>{
      'id': instance.id,
      'to': instance.to,
      'to_full_name': instance.to_full_name,
      'by': instance.by,
      'by_full_name': instance.by_full_name,
      'by_image': instance.by_image,
      'description': instance.description,
      'available_at': instance.available_at.toIso8601String(),
      'is_read': instance.is_read,
      'replies': instance.replies,
      'image': instance.image,
    };
