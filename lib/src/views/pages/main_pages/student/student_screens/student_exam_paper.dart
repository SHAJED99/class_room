import 'package:class_room/src/models/pojo_classes/exam_model.dart';
import 'package:flutter/material.dart';

class StudentExamPaper extends StatefulWidget {
  const StudentExamPaper({super.key, required this.examModel});
  final ExamModel examModel;

  @override
  State<StudentExamPaper> createState() => _StudentExamPaperState();
}

class _StudentExamPaperState extends State<StudentExamPaper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Exam: ${widget.examModel.examName}")),
        body: PageView(
          children: [
            SingleChildScrollView(
              child: Column(),
            ),
          ],
        ));
  }
}
