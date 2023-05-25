// ignore_for_file: prefer_const_constructors

import 'package:class_room/app_constants.dart';
import 'package:class_room/src/controllers/data_controllers/data_controller.dart';
import 'package:class_room/src/models/pojo_classes/exam_model.dart';
import 'package:class_room/src/models/pojo_classes/question_model.dart';
import 'package:class_room/src/views/pages/main_pages/student/student_screens/student_show_exam_result.dart';
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => StudentShowExamResult(examModel: widget.examModel)),
        child: Text("Done"),
      ),
    );
  }
}

class StudentExamPage extends StatelessWidget {
  final QuestionModel questionModel;
  final int index;
  StudentExamPage({super.key, required this.questionModel, required this.index});
  final _formKey = GlobalKey<FormState>();
  final DataController dataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Form(
        key: _formKey,
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${index + 1}. ${questionModel.question}", style: buttonText1.copyWith(color: defaultBlackColor)),
                Column(children: [
                  for (var e in questionModel.possibleAnswers.asMap().entries.map((e) => e).toList())
                    CustomElevatedButton(
                      constraints: BoxConstraints(minHeight: defaultBoxHeight),
                      backgroundColor: (dataController.selectedAnswer[index] == e.key) ? Theme.of(context).primaryColor : Theme.of(context).primaryColorLight,
                      height: null,
                      margin: EdgeInsets.symmetric(vertical: defaultPadding / 2),
                      onDone: (_) => dataController.selectedAnswer[index] = e.key,
                      child: Row(
                        children: [
                          CustomRoundedMCQSelectionId(e.key + 1, isActive: dataController.selectedAnswer[index] == e.key),
                          SizedBox(width: defaultPadding / 2),
                          Flexible(
                            child: Text(
                              e.value.capitalizeFirst ?? "",
                              style: buttonText1.copyWith(color: defaultBlackColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: defaultCarouselHeight)
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
