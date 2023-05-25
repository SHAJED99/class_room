import 'package:class_room/app_constants.dart';
import 'package:class_room/src/models/pojo_classes/question_model.dart';
import 'package:class_room/src/views/widgets/buttons/custom_elevated_button_widget.dart';
import 'package:class_room/src/views/widgets/buttons/custom_rounded_button.dart';
import 'package:class_room/src/views/widgets/text/custom_rounded_mcq_selection_id.dart';
import 'package:class_room/src/views/widgets/text/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddQuestionTile extends StatefulWidget {
  final int? count;
  final QuestionModel? questionModel;
  final Function(QuestionModel question) onDone;
  const AddQuestionTile({
    super.key,
    this.count,
    required this.onDone,
    this.questionModel,
  });

  @override
  State<AddQuestionTile> createState() => _AddQuestionTileState();
}

class _AddQuestionTileState extends State<AddQuestionTile> {
  final RxString question = "".obs;
  final RxInt correctAns = (-1).obs;
  final _formKey = GlobalKey<FormState>();
  final List<String> possibleAnswer = [];

  @override
  void initState() {
    super.initState();
    if (widget.questionModel == null) return;
    correctAns.value = widget.questionModel!.correctAnswer;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomTextFormField(
              initialValue: widget.questionModel == null ? null : widget.questionModel!.question,
              labelText: "${widget.count == null ? "" : "${widget.count}. "}Question",
              suffix: const Text("?"),
              validator: (value) {
                if (value == null || value.trim().isEmpty) return "Enter valid data";
                question.value = value.trim();
              },
            ),
            for (int i = 0; i < (widget.questionModel == null ? 4 : widget.questionModel!.possibleAnswers.length); i++)
              Container(
                padding: const EdgeInsets.only(top: defaultPadding),
                child: Row(
                  children: [
                    CustomRoundedButton(
                      onTap: () async {
                        correctAns.value = i;
                        return;
                      },
                      child: CustomRoundedMCQSelectionId(i + 1, isActive: correctAns.value == i),
                    ),
                    Expanded(
                      child: CustomTextFormField(
                        initialValue: widget.questionModel == null ? null : widget.questionModel!.possibleAnswers[i],
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) return "Enter valid data";
                          possibleAnswer.add(value.trim());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: defaultPadding),
            CustomElevatedButton(
              contentPadding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
              onTap: () async {
                if (correctAns.value == -1) return false;
                return _formKey.currentState?.validate() ?? false;
              },
              onDone: (isSuccess) {
                if (isSuccess ?? false) {
                  widget.onDone(QuestionModel(question: question.value, possibleAnswers: possibleAnswer, correctAnswer: correctAns.value));
                }
              },
              child: const Text("Submit", style: buttonText1),
            )
          ],
        ),
      ),
    );
  }
}
