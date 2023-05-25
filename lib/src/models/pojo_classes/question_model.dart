// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class QuestionModel {
  final String question;
  final List<String> possibleAnswers;
  final int correctAnswer;
  QuestionModel({
    required this.question,
    required this.possibleAnswers,
    required this.correctAnswer,
  });

  QuestionModel copyWith({
    String? question,
    List<String>? possibleAnswers,
    int? correctAnswer,
  }) {
    return QuestionModel(
      question: question ?? this.question,
      possibleAnswers: possibleAnswers ?? this.possibleAnswers,
      correctAnswer: correctAnswer ?? this.correctAnswer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': question,
      'possibleAnswers': possibleAnswers,
      'correctAnswer': correctAnswer,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      question: map['question'] as String,
      possibleAnswers: List<String>.from((map['possibleAnswers'])),
      correctAnswer: map['correctAnswer'] as int,
    );
  }

  factory QuestionModel.fromJson(String source) => QuestionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'QuestionModel(question: $question, possibleAnswers: $possibleAnswers, correctAnswer: $correctAnswer)';

  @override
  bool operator ==(covariant QuestionModel other) {
    if (identical(this, other)) return true;

    return other.question == question && listEquals(other.possibleAnswers, possibleAnswers) && other.correctAnswer == correctAnswer;
  }

  @override
  int get hashCode => question.hashCode ^ possibleAnswers.hashCode ^ correctAnswer.hashCode;
}
