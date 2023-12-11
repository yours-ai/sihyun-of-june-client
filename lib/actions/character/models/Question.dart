import 'package:json_annotation/json_annotation.dart';

part 'Question.g.dart';

@JsonSerializable()
class Question {
  int id;
  String question_text;
  String choice_1_text;
  String choice_2_text;

  Question(
      {required this.id,
      required this.question_text,
      required this.choice_1_text,
      required this.choice_2_text});

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
