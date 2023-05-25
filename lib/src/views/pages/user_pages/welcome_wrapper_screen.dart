// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:class_room/src/controllers/data_controllers/data_controller.dart';
import 'package:class_room/src/views/pages/user_pages/signup_page.dart';
import 'package:class_room/src/views/pages/user_pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeWrapperScreen extends StatefulWidget {
  const WelcomeWrapperScreen({super.key});

  @override
  State<WelcomeWrapperScreen> createState() => _WelcomeWrapperScreenState();
}

class _WelcomeWrapperScreenState extends State<WelcomeWrapperScreen> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();

    Get.put(DataController());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              WelcomePage(pageController: pageController),
              SignUpPage(),
            ],
          ),
        ),
      ),
    );
  }
}
