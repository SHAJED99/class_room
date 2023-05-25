import 'package:class_room/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar({required String title, required String message, Widget? icon}) {
  Get.snackbar(
    title,
    message,
    icon: icon,
    borderRadius: defaultPadding / 2,
    padding: const EdgeInsets.all(defaultPadding),
    margin: const EdgeInsets.all(defaultPadding),
    maxWidth: 500,
    backgroundColor: Colors.white70,
  );
}
