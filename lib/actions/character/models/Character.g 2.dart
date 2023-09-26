// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      id: json['id'] as int,
      is_active: json['is_active'] as bool,
      name: json['name'] as String?,
      age: json['age'] as int?,
      MBTI: json['MBTI'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String,
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'id': instance.id,
      'is_active': instance.is_active,
      'name': instance.name,
      'age': instance.age,
      'MBTI': instance.MBTI,
      'description': instance.description,
      'image': instance.image,
    };
