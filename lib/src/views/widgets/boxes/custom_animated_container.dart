import 'package:class_room/app_constants.dart';
import 'package:flutter/material.dart';

class CustomAnimatedContainer extends StatelessWidget {
  const CustomAnimatedContainer({super.key, this.child, this.duration = defaultDuration});
  final int duration;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      alignment: Alignment.topLeft,
      duration: Duration(milliseconds: duration),
      child: child,
    );
  }
}
