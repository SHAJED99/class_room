import 'package:class_room/app_constants.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.child,
    this.padding = const EdgeInsets.all(8),
    this.margin = const EdgeInsets.all(8),
    this.constraints = const BoxConstraints(maxWidth: 400),
  });
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: constraints,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(),
      child: child,
    );
  }
}
