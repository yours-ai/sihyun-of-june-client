// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      id: json['id'] as num,
      question_text: json['question_text'] as String,
      choice_1_text: json['choice_1_text'] as String,
      choice_2_text: json['choice_2_text'] as String,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'question_text': instance.question_text,
      'choice_1_text': instance.choice_1_text,
      'choice_2_text': instance.choice_2_text,
    };
