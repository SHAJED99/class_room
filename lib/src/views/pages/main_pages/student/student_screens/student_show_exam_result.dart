import 'dart:math';

import 'package:class_room/app_constants.dart';
import 'package:class_room/src/controllers/data_controllers/data_controller.dart';
import 'package:class_room/src/models/pojo_classes/exam_model.dart';
import 'package:class_room/src/models/pojo_classes/question_model.dart';
import 'package:class_room/src/views/widgets/buttons/custom_elevated_button_widget.dart';
import 'package:class_room/src/views/widgets/text/custom_rounded_mcq_selection_id.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentShowExamResult extends StatelessWidget {
  final ExamModel examModel;
  StudentShowExamResult({super.key, required this.examModel});

  final DataController dataController = Get.find();

  int countCorrectAnswer() {
    int res = 0;

    for (var element in examModel.questions.asMap().entries.map((e) => e).toList()) {
      if (element.value.correctAnswer == dataController.selectedAnswer[element.key]) {
        res = res + 1;
      }
    }
    return res;
  }

  Color colorSelection(BuildContext context, int selectedValue, int correctedValue) {
    if (selectedValue == -1) return Theme.of(context).primaryColorLight;

    if (selectedValue == correctedValue) return Theme.of(context).primaryColor;

    return defaultErrorColor;
  }

  Widget? iconSelection(BuildContext context, int selectedValue, int correctedValue, int i) {
    // If not selected
    if (selectedValue == -1 && correctedValue == i) return const Icon(Icons.done, color: defaultBlackColor);

    if (selectedValue == correctedValue) {
      // If Answer is corrected
      if (correctedValue == i) {
        return Icon(Icons.done, color: Theme.of(context).primaryColor);
      }
    } else {
      // If Answer is not correct
      if (selectedValue == i) {
        return const Icon(Icons.cancel, color: defaultErrorColor);
      } else if (correctedValue == i) {
        return const Icon(Icons.done, color: defaultErrorColor);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Exam Result")),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Exam Summary:", style: buttonText1.copyWith(color: defaultBlackColor)),
              const SizedBox(height: defaultPadding / 4),
              Text("Correct Answer: ${countCorrectAnswer()}", style: defaultSubtitle1.copyWith(color: defaultBlackColor)),
              const SizedBox(height: defaultPadding),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (MapEntry<int, QuestionModel> element in examModel.questions.asMap().entries.map((e) => e).toList())
                    CustomElevatedButton(
                      enable: false,
                      margin: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
                      contentPadding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding / 2),
                      height: null,
                      constraints: const BoxConstraints(minHeight: defaultBoxHeight),
                      backgroundColor: colorSelection(context, dataController.selectedAnswer[element.key], element.value.correctAnswer).withOpacity(0.3),
                      boxShadow: defaultBoxShadowDown,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Q ${element.key + 1}. ${element.value.question}", style: buttonText1.copyWith(color: defaultBlackColor)),
                          const SizedBox(height: defaultPadding),
                          for (var e in element.value.possibleAnswers.asMap().entries.map((e) => e).toList())
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: defaultPadding / 4),
                              child: Row(
                                children: [
                                  iconSelection(context, dataController.selectedAnswer[element.key], element.value.correctAnswer, e.key) ?? CustomRoundedMCQSelectionId(e.key + 1),
                                  const SizedBox(width: defaultPadding / 2),
                                  Expanded(
                                    child: Text(
                                      element.value.question.capitalizeFirst ?? "",
                                      style: defaultSubtitle1.copyWith(color: defaultBlackColor),
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
