// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:class_room/app_constants.dart';
import 'package:class_room/src/controllers/data_controllers/data_controller.dart';
import 'package:class_room/src/models/pojo_classes/exam_model.dart';
import 'package:class_room/src/models/pojo_classes/question_model.dart';
import 'package:class_room/src/views/widgets/boxes/custom_animated_container.dart';
import 'package:class_room/src/views/widgets/boxes/custom_container.dart';
import 'package:class_room/src/views/widgets/buttons/custom_elevated_button_widget.dart';
import 'package:class_room/src/views/widgets/buttons/custom_rounded_button.dart';
import 'package:class_room/src/views/widgets/text/add_question_tile.dart';
import 'package:class_room/src/views/widgets/text/added_question_tile.dart';
import 'package:class_room/src/views/widgets/text/custom_text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddQuestionScreen extends StatefulWidget {
  const AddQuestionScreen({super.key});

  @override
  State<AddQuestionScreen> createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  final DataController dataController = Get.find();

  RxList<QuestionModel> questions = RxList();
  RxBool expandAddQuestion = true.obs;

  final _formKey = GlobalKey<FormState>();

  String examName = "";
  String examDescription = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Question"),
        actions: [
          Center(
            child: CustomRoundedButton(
              iconColor: defaultWhiteColor,
              onTap: () async {
                if (!(_formKey.currentState?.validate() ?? true)) return false;
                if (questions.isEmpty) return false;
                await dataController.addExam(examModel: ExamModel(teacherEmail: FirebaseAuth.instance.currentUser?.email ?? "", createOn: DateTime.now(), participationTime: 0, questions: questions, examName: examName, examDescription: examDescription));
                return true;
              },
              onDone: (isSuccess) {
                if (isSuccess ?? false) Get.back();
              },
              child: Icon(Icons.done),
            ),
          ),
          SizedBox(
            width: defaultPadding / 2,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: CustomContainer(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //! Exam Name
                CustomTextFormField(
                  hintText: "Exam Name",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return "Enter valid data";
                    examName = value.trim();
                  },
                ),

                SizedBox(height: defaultPadding),

                //! Exam Description
                CustomTextFormField(
                  contentPadding: EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding),
                  hintText: "Description",
                  height: null,
                  minLines: 3,
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return "Enter valid data";
                    examDescription = value.trim();
                  },
                ),

                SizedBox(height: defaultPadding),

                //! Total Question Text
                Obx(() => Text("Total Question ${questions.length}", style: defaultSubtitle1)),

                //! Added Question
                Obx(
                  () => CustomAnimatedContainer(
                    child: Column(
                      children: [
                        for (int i = 0; i < questions.length; i++)
                          AddedQuestionTile(
                            index: i + 1,
                            questionModel: questions[i],
                            onDelete: () {
                              questions.remove(questions[i]);
                            },
                            onTap: (questionModel) {
                              questions[i] = questionModel;
                            },
                          ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: defaultPadding),

                //! Add Button
                CustomElevatedButton(
                  onDone: (_) => expandAddQuestion.value = true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: defaultWhiteColor),
                      SizedBox(width: defaultPadding / 2),
                      Text("Add", style: buttonText1),
                      SizedBox(width: defaultPadding / 2),
                    ],
                  ),
                ),

                SizedBox(height: defaultPadding),

                //! Add Question
                Obx(
                  () => CustomAnimatedContainer(
                    child: !expandAddQuestion.value
                        ? SizedBox()
                        : AddQuestionTile(
                            count: questions.length + 1,
                            onDone: (question) {
                              questions.add(question);
                              expandAddQuestion.value = false;
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
