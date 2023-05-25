// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class TeacherExamIdResponseModel {
  List<String> exam;

  TeacherExamIdResponseModel({
    required this.exam,
  });

  TeacherExamIdResponseModel copyWith({
    List<String>? exam,
  }) {
    return TeacherExamIdResponseModel(
      exam: exam ?? this.exam,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'exam': exam,
    };
  }

  factory TeacherExamIdResponseModel.fromMap(Map<String, dynamic> map) {
    return TeacherExamIdResponseModel(
        exam: List<String>.from(
      (map['exam']),
    ));
  }

  factory TeacherExamIdResponseModel.fromJson(String source) => TeacherExamIdResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TeacherExamIdResponseModel(exam: $exam)';

  @override
  bool operator ==(covariant TeacherExamIdResponseModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.exam, exam);
  }

  @override
  int get hashCode => exam.hashCode;
}
