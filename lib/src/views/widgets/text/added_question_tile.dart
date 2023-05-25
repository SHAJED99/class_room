import 'package:class_room/app_constants.dart';
import 'package:class_room/src/models/pojo_classes/question_model.dart';
import 'package:class_room/src/views/widgets/buttons/custom_elevated_button_widget.dart';
import 'package:class_room/src/views/widgets/buttons/custom_rounded_button.dart';
import 'package:class_room/src/views/widgets/text/add_question_tile.dart';
import 'package:class_room/src/views/widgets/text/custom_rounded_mcq_selection_id.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddedQuestionTile extends StatelessWidget {
  final Function(QuestionModel questionModel) onTap;
  final Function()? onDelete;
  final int? index;
  final QuestionModel questionModel;
  AddedQuestionTile({
    super.key,
    required this.onTap,
    this.index,
    required this.questionModel,
    this.onDelete,
  });

  final RxBool isEdit = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          CustomElevatedButton(
            onLongPress: () {
              if (isEdit.value) return;
              isEdit.value = true;
            },
            height: null,
            expanded: true,
            boxShadow: defaultBoxShadowDown,
            backgroundColor: Colors.transparent,
            contentPadding: const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding),
            margin: const EdgeInsets.only(top: defaultPadding),
            child: isEdit.value
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: defaultPadding * 3),
                      AddQuestionTile(
                        count: index,
                        questionModel: questionModel,
                        onDone: (question) {
                          onTap(question);
                          isEdit.value = false;
                        },
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${index == null ? "" : "$index. "} ${questionModel.question}",
                        style: defaultTitleStyle1,
                      ),
                      for (int j = 0; j < questionModel.possibleAnswers.length; j++)
                        Container(
                          padding: const EdgeInsets.only(top: defaultPadding),
                          child: Row(
                            children: [
                              CustomRoundedMCQSelectionId(j + 1, isActive: questionModel.correctAnswer == j),
                              const SizedBox(width: defaultPadding / 2),
                              Expanded(
                                child: Text(
                                  questionModel.possibleAnswers[j],
                                  style: buttonText1.copyWith(color: defaultBlackColor),
                                ),
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
          ),
          //! Cancel
          if (isEdit.value)
            Positioned(
              left: 0,
              top: defaultPadding,
              child: CustomRoundedButton(
                onTap: () async {
                  isEdit.value = false;
                  return;
                },
                child: Icon(Icons.cancel, color: Theme.of(context).primaryColor),
              ),
            ),
          //! Delete
          if (isEdit.value && onDelete != null)
            Positioned(
              right: 0,
              top: defaultPadding,
              child: CustomRoundedButton(
                onTap: () async {
                  if (onDelete != null) onDelete!();
                  return;
                },
                child: const Icon(Icons.delete, color: defaultErrorColor),
              ),
            ),
        ],
      ),
    );
  }
}
