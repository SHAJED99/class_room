// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:class_room/app_constants.dart';
import 'package:class_room/src/controllers/data_controllers/data_controller.dart';
import 'package:class_room/src/views/pages/main_pages/student/student_screens/student_exam_front_page.dart';
import 'package:class_room/src/views/widgets/animations/custom_circular_loading_bar.dart';
import 'package:class_room/src/views/widgets/boxes/custom_animated_container.dart';
import 'package:class_room/src/views/widgets/buttons/custom_elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
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
                      : Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Total Exam: ${dataController.examList.length}", style: defaultSubtitle1.copyWith(color: defaultBlackColor)),
                              Column(
                                children: dataController.examList
                                    .map(
                                      (element) => CustomElevatedButton(
                                        contentPadding: EdgeInsets.symmetric(horizontal: defaultPadding / 2, vertical: defaultPadding / 2),
                                        backgroundColor: Theme.of(context).primaryColorLight,
                                        enable: true,
                                        height: null,
                                        boxShadow: defaultBoxShadowDown,
                                        margin: EdgeInsets.symmetric(vertical: defaultPadding / 4),
                                        onDone: (_) => Get.to(() => StudentExamFrontPage(examModel: element)),
                                        child: FractionallySizedBox(
                                          widthFactor: 1,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(element.examName, maxLines: 2, overflow: TextOverflow.ellipsis, style: defaultTitleStyle1),
                                              const SizedBox(height: defaultPadding / 4),
                                              Text(DateFormat('dd.MMMM.yyyy\nh:mm a').format(element.createOn), style: defaultSubtitle2),
                                              const SizedBox(height: defaultPadding / 2),
                                              Text(element.examDescription, maxLines: 3, overflow: TextOverflow.ellipsis, style: buttonText1.copyWith(color: defaultBlackColor)),
                                              const SizedBox(height: defaultPadding / 4),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
