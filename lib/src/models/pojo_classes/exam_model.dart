// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:class_room/src/models/pojo_classes/question_model.dart';

class ExamModel {
  final String? examId;
  final String teacherEmail;
  final DateTime createOn;
  final int participationTime;
  final List<QuestionModel> questions;
  final String examName;
  final String examDescription;
  ExamModel({
    this.examId,
    required this.teacherEmail,
    required this.createOn,
    required this.participationTime,
    required this.questions,
    required this.examName,
    required this.examDescription,
  });

  ExamModel copyWith({
    String? examId,
    String? teacherEmail,
    DateTime? createOn,
    int? participationTime,
    List<QuestionModel>? questions,
    String? examName,
    String? examDescription,
  }) {
    return ExamModel(
      examId: examId ?? this.examId,
      teacherEmail: teacherEmail ?? this.teacherEmail,
      createOn: createOn ?? this.createOn,
      participationTime: participationTime ?? this.participationTime,
      questions: questions ?? this.questions,
      examName: examName ?? this.examName,
      examDescription: examDescription ?? this.examDescription,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'teacherEmail': teacherEmail,
      'createOn': createOn.millisecondsSinceEpoch,
      'participationTime': participationTime,
      'questions': questions.map((x) => x.toMap()).toList(),
      'examName': examName,
      'examDescription': examDescription,
    };
  }

  factory ExamModel.fromMap(Map<String, dynamic> map) {
    return ExamModel(
      examId: map['examId'] != null ? map['examId'] as String : null,
      teacherEmail: map['teacherEmail'] as String,
      createOn: DateTime.fromMillisecondsSinceEpoch(map['createOn'] as int),
      participationTime: map['participationTime'] as int,
      questions: List<QuestionModel>.from(
        (map['questions'] as List<dynamic>).map<QuestionModel>(
          (x) => QuestionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      examName: map['examName'] as String,
      examDescription: map['examDescription'] as String,
    );
  }

  factory ExamModel.fromJson(String source) => ExamModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ExamModel(examId: $examId, teacherEmail: $teacherEmail, createOn: $createOn, participationTime: $participationTime, questions: $questions, examName: $examName, examDescription: $examDescription)';
  }

  @override
  bool operator ==(covariant ExamModel other) {
    if (identical(this, other)) return true;

    return other.examId == examId && other.teacherEmail == teacherEmail && other.createOn == createOn && other.participationTime == participationTime && listEquals(other.questions, questions) && other.examName == examName && other.examDescription == examDescription;
  }

  @override
  int get hashCode {
    return examId.hashCode ^ teacherEmail.hashCode ^ createOn.hashCode ^ participationTime.hashCode ^ questions.hashCode ^ examName.hashCode ^ examDescription.hashCode;
  }
}
