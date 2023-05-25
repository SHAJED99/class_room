// ignore_for_file: prefer_const_constructors

import 'package:class_room/app_constants.dart';
import 'package:class_room/src/models/pojo_classes/exam_model.dart';
import 'package:class_room/src/models/pojo_classes/question_model.dart';
import 'package:class_room/src/views/widgets/boxes/custom_container.dart';
import 'package:class_room/src/views/widgets/buttons/custom_elevated_button_widget.dart';
import 'package:class_room/src/views/widgets/text/custom_rounded_mcq_selection_id.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentExamPaper extends StatefulWidget {
  const StudentExamPaper({super.key, required this.examModel});
  final ExamModel examModel;

  @override
  State<StudentExamPaper> createState() => _StudentExamPaperState();
}

class _StudentExamPaperState extends State<StudentExamPaper> {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Exam: ${widget.examModel.examName}")),
        body: PageView(
          // physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            for (int i = 0; i < widget.examModel.questions.length; i++) StudentExamPage(questionModel: widget.examModel.questions[i], index: i),
          ],
        ));
  }
}

class StudentExamPage extends StatelessWidget {
  final QuestionModel questionModel;
  final int index;
  StudentExamPage({super.key, required this.questionModel, required this.index});
  final _formKey = GlobalKey<FormState>();
  final RxInt selectedAnswer = (-1).obs;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${index + 1}. ${questionModel.question}", style: buttonText1.copyWith(color: defaultBlackColor)),
              Column(
                children: questionModel.possibleAnswers
                    .asMap()
                    .entries
                    .map(
                      (e) => CustomElevatedButton(
                        constraints: BoxConstraints(minHeight: defaultBoxHeight),
                        backgroundColor: Theme.of(context).primaryColorLight,
                        height: null,
                        margin: EdgeInsets.symmetric(vertical: defaultPadding / 2),
                        child: Row(
                          children: [
                            CustomRoundedMCQSelectionId(e.key + 1),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
