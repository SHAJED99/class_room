import 'package:class_room/app_constants.dart';
import 'package:class_room/src/views/pages/user_pages/welcome_wrapper_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      initialBinding: InitializedBinding(),
      theme: ThemeData(
        primarySwatch: defaultPrimarySwatch,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: defaultPrimarySwatch).copyWith(
          error: defaultErrorColor,
        ),
      ),
      scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
      }),
      home: const WelcomeWrapperScreen(),
    );
  }
}

class InitializedBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put(DataController());
  }
}
