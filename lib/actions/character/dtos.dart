import 'package:flutter/material.dart';

@immutable
class AnswerDTO {
  final int question_id;
  final int choice;

  const AnswerDTO({required this.question_id, required this.choice});
}

class AnswerDTOList {
  List<AnswerDTO> answers;

  AnswerDTOList({required this.answers});

  void addAnswer(AnswerDTO newAnswer) {
    answers.add(newAnswer);
  }

  List<Map<String, int>> toJsonList() {
    return answers
        .map((answer) => {
              'question_id': answer.question_id,
              'choice': answer.choice,
            })
        .toList();
  }
}

@immutable
class denyTestChoiceDTO {
  final int id;
  final String payment;

  const denyTestChoiceDTO({required this.id, required this.payment});
}
