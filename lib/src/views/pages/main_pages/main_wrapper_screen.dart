// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:class_room/app_constants.dart';
import 'package:class_room/src/controllers/data_controllers/data_controller.dart';
import 'package:class_room/src/models/enum/enter_as.dart';
import 'package:class_room/src/views/pages/main_pages/student/student_wrapper_screen.dart';
import 'package:class_room/src/views/pages/main_pages/teacher/teacher_wrapper_screen.dart';
import 'package:class_room/src/views/widgets/buttons/custom_elevated_button_widget.dart';

import 'package:class_room/src/views/widgets/image/custom_rounded_profile_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MainWrapperScreen extends StatelessWidget {
  MainWrapperScreen({super.key});
  final DataController dataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        dataController.autoSignOut();
        return true;
      },
      child: Obx(
        () => Scaffold(
          key: dataController.scaffoldKey,
          appBar: AppBar(
            title: Text("${FirebaseAuth.instance.currentUser?.displayName}"),
            actions: [
              CustomRoundedProfileImageWidget(
                onTap: () {
                  if (dataController.scaffoldKey.currentState != null) dataController.scaffoldKey.currentState?.openEndDrawer();
                },
                link: FirebaseAuth.instance.currentUser?.photoURL,
              ),
              SizedBox(width: defaultPadding / 4),
            ],
          ),
          body: dataController.enterAs.value == EnterAs.teacher ? TeacherWrappedScreen() : StudentWrappedScreen(),
          endDrawer: Container(
            decoration: BoxDecoration(color: defaultWhiteColor),
            margin: EdgeInsets.only(left: defaultBoxHeight * 2),
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            constraints: BoxConstraints(maxWidth: defaultMaxWidth),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${FirebaseAuth.instance.currentUser?.displayName}", style: buttonText1.copyWith(color: defaultBlackColor)),
                          SizedBox(height: defaultPadding / 4),
                          Text(dataController.enterAs.value == EnterAs.teacher ? "Teacher" : "Student", style: defaultSubtitle1),
                          SizedBox(height: defaultPadding / 4),
                          Text("${FirebaseAuth.instance.currentUser?.email}", style: defaultSubtitle1.copyWith(color: defaultBlackColor)),
                          SizedBox(height: defaultPadding / 4),
                          Text("Created on: ${DateFormat('dd.MMMM.yyyy h:mm a').format(FirebaseAuth.instance.currentUser?.metadata.creationTime ?? DateTime.now())}", style: defaultSubtitle1.copyWith(color: defaultBlackColor)),
                          SizedBox(height: defaultPadding / 4),
                          Text("Phone number: ${FirebaseAuth.instance.currentUser?.phoneNumber}", style: defaultSubtitle1.copyWith(color: defaultBlackColor)),
                        ],
                      ),
                    ),
                    Spacer(),
                    CustomElevatedButton(
                      expanded: true,
                      onTap: () async {
                        dataController.signOut();
                        return;
                      },
                      child: Text("Logout", style: buttonText1),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
