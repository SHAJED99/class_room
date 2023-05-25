import 'package:class_room/app_constants.dart';
import 'package:class_room/src/models/pojo_classes/exam_model.dart';
import 'package:class_room/src/views/pages/main_pages/student/student_screens/student_exam_paper.dart';
import 'package:class_room/src/views/widgets/boxes/custom_animated_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StudentExamFrontPage extends StatelessWidget {
  final ExamModel examModel;
  const StudentExamFrontPage({super.key, required this.examModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Exam")),
      body: LayoutBuilder(builder: (context, box) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultPadding),
            constraints: BoxConstraints(minHeight: box.maxHeight + 0.1, minWidth: box.maxWidth),
            child: CustomAnimatedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(examModel.examName, style: buttonText1.copyWith(color: defaultBlackColor)),
                  const SizedBox(height: defaultPadding / 2),
                  Text(examModel.examDescription, textAlign: TextAlign.justify, style: defaultSubtitle1.copyWith(color: defaultBlackColor)),
                  const SizedBox(height: defaultPadding),
                  const Divider(height: 1, thickness: 1),
                  const SizedBox(height: defaultPadding / 2),
                  Text(DateFormat('dd.MMMM.yyyy\nh:mm a').format(examModel.createOn), style: defaultSubtitle2),
                  const SizedBox(height: defaultPadding / 2),
                  const Divider(height: 1, thickness: 1),
                  const SizedBox(height: defaultPadding / 2),
                  Text("Total Question: ${examModel.questions.length}", style: defaultSubtitle1.copyWith(color: defaultBlackColor)),
                  const SizedBox(height: defaultPadding / 8),
                  Text("Taken exam: ${examModel.participationTime} times", style: defaultSubtitle1.copyWith(color: defaultBlackColor)),
                  const SizedBox(height: defaultPadding / 8),
                  Text("Created by: ${examModel.teacherEmail}", style: defaultSubtitle1.copyWith(color: defaultBlackColor)),
                ],
              ),
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => StudentExamPaper(examModel: examModel)),
        child: const Text("Start"),
      ),
    );
  }
}
