// ignore_for_file: prefer_const_constructors

import 'package:class_room/app_constants.dart';
import 'package:class_room/src/controllers/data_controllers/data_controller.dart';
import 'package:class_room/src/views/pages/main_pages/teacher/teacher_screens/add_question_screen.dart';
import 'package:class_room/src/views/pages/main_pages/teacher/teacher_screens/home_carousel.dart';
import 'package:class_room/src/views/widgets/animations/custom_circular_loading_bar.dart';
import 'package:class_room/src/views/widgets/boxes/custom_animated_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherHomeScreen extends StatefulWidget {
  const TeacherHomeScreen({super.key});

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  final DataController dataController = Get.find();
  final RxBool isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    isLoading.value = true;
    await dataController.getExamList();
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, box) {
        return RefreshIndicator(
          onRefresh: () async => await loadData(),
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(minHeight: box.maxHeight + 0.1, minWidth: box.maxWidth),
              child: CustomAnimatedContainer(
                child: Obx(
                  () => isLoading.value
                      ? Center(child: CustomCircularProgressBar())
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (dataController.examList.isNotEmpty) HomeCarousel(),
                            Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Summary:", style: defaultTitleStyle1),
                                  SizedBox(height: defaultPadding / 4),
                                  Text("Total Exam: ${dataController.examList.length}", style: defaultSubtitle1),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton.small(
        child: Icon(Icons.add),
        onPressed: () => Get.to(() => AddQuestionScreen()),
      ),
    );
  }
}
