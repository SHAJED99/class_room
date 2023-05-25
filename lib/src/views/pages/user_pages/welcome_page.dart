import 'package:class_room/app_constants.dart';
import 'package:class_room/src/controllers/data_controllers/data_controller.dart';
import 'package:class_room/src/models/enum/enter_as.dart';
import 'package:class_room/src/views/pages/user_pages/signup_page.dart';
import 'package:class_room/src/views/widgets/animations/custom_circular_loading_bar.dart';
import 'package:class_room/src/views/widgets/boxes/custom_animated_container.dart';
import 'package:class_room/src/views/widgets/buttons/custom_elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomePage extends StatefulWidget {
  final PageController pageController;
  const WelcomePage({
    super.key,
    required this.pageController,
  });

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final DataController dataController = Get.find();
  final RxBool isInit = false.obs;

  @override
  void initState() {
    super.initState();
    dataController.initApp().then((value) => isInit.value = true);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Container(
                constraints: const BoxConstraints(maxWidth: defaultMaxWidth),
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    Text(appTitle, style: defaultTitleStyle1.copyWith(color: defaultWhiteColor)),
                    const SizedBox(height: defaultPadding / 2),
                    const Text(appSubtitle, style: buttonText1),
                    CustomAnimatedContainer(
                      // duration: 500,
                      child: FractionallySizedBox(
                        widthFactor: 1,
                        child: !isInit.value
                            ? const SizedBox()
                            : Column(
                                children: [
                                  const SizedBox(height: defaultPadding * 2),
                                  CustomElevatedButton(
                                    expanded: true,
                                    backgroundColor: defaultWhiteColor,
                                    onTap: () {
                                      dataController.enterAs.value = EnterAs.teacher;
                                      widget.pageController.animateToPage(1, duration: const Duration(milliseconds: defaultDuration), curve: Curves.linear);
                                      return;
                                    },
                                    child: Text("Sign in as a teacher", style: buttonText1.copyWith(color: defaultBlackColor)),
                                  ),
                                  const SizedBox(height: defaultPadding / 2),
                                  CustomElevatedButton(
                                    expanded: true,
                                    backgroundColor: defaultWhiteColor,
                                    onTap: () {
                                      dataController.enterAs.value = EnterAs.student;
                                      widget.pageController.animateToPage(1, duration: const Duration(milliseconds: defaultDuration), curve: Curves.linear);
                                      return;
                                    },
                                    child: Text("Sign in as a student", style: buttonText1.copyWith(color: defaultBlackColor)),
                                  ),
                                  const SizedBox(height: defaultPadding * 2),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(defaultPadding),
              alignment: Alignment.bottomCenter,
              // color: Colors.amber,
              child: Column(
                children: [
                  CustomAnimatedContainer(child: isInit.value ? null : const CustomCircularProgressBar(color: defaultWhiteColor)),
                  const SizedBox(height: defaultPadding / 2),
                  const Text(appVersion, style: defaultSubtitle1),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
