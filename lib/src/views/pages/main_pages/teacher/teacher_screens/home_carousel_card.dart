import 'package:class_room/app_constants.dart';
import 'package:flutter/material.dart';

class HomeCarouselCard extends StatelessWidget {
  final void Function()? onTap;
  final Widget? child;
  final EdgeInsetsGeometry? padding;

  const HomeCarouselCard({
    super.key,
    this.onTap,
    this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 1,
        child: Container(
          margin: padding ?? const EdgeInsets.symmetric(horizontal: defaultPadding / 4, vertical: defaultPadding / 4),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: defaultWhiteColor,
            borderRadius: BorderRadius.circular(defaultPadding / 2),
            boxShadow: defaultBoxShadowDown,
          ),
          child: child,
        ),
      ),
    );
  }
}
