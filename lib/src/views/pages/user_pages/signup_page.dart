// ignore_for_file: prefer_const_constructors

import 'package:class_room/app_constants.dart';
import 'package:class_room/src/controllers/data_controllers/data_controller.dart';
import 'package:class_room/src/models/enum/enter_as.dart';
import 'package:class_room/src/views/pages/main_pages/main_wrapper_screen.dart';
import 'package:class_room/src/views/widgets/buttons/custom_elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  final DataController dataController = Get.find();
  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(maxWidth: defaultMaxWidth),
                padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    Text(dataController.enterAs.value == EnterAs.teacher ? "Teacher" : "Student", style: defaultTitleStyle1.copyWith(color: defaultWhiteColor)),
                    SizedBox(height: defaultPadding * 2),
                    FractionallySizedBox(
                      widthFactor: 1,
                      child: CustomElevatedButton(
                        expanded: true,
                        backgroundColor: defaultWhiteColor,
                        iconColor: Theme.of(context).primaryColor,
                        onTap: () async {
                          return await dataController.login();
                        },
                        onDone: (isSuccess) {
                          if (isSuccess ?? false) Get.offAll(() => MainWrapperScreen());
                        },
                        child: Text("Sign In with google", style: buttonText1.copyWith(color: defaultBlackColor)),
                      ),
                    ),
                    SizedBox(height: defaultPadding * 2),
                    CustomElevatedButton(
                      height: null,
                      contentPadding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding / 2),
                      onDone: (_) {
                        dataController.enterAs.value = dataController.enterAs.value == EnterAs.teacher ? EnterAs.student : EnterAs.teacher;
                      },
                      child: FittedBox(child: Text("Enter as a ${dataController.enterAs.value == EnterAs.student ? "Teacher" : "Student"}", style: buttonText1)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
