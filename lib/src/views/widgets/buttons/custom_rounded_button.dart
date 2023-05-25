import 'package:class_room/app_constants.dart';
import 'package:class_room/src/views/widgets/buttons/custom_elevated_button_widget.dart';
import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  final Future<bool?>? Function()? onTap;
  final dynamic Function(bool? isSuccess)? onDone;
  final void Function()? onLongPress;
  final Widget? child;
  final bool enable;
  final Color? iconColor;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  const CustomRoundedButton({
    super.key,
    this.onTap,
    this.child,
    this.enable = true,
    this.onLongPress,
    this.iconColor,
    this.margin = const EdgeInsets.all(defaultPadding / 4),
    this.backgroundColor = Colors.transparent,
    this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      enable: enable,
      iconColor: iconColor ?? Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(100),
      height: defaultBoxHeight - defaultPadding / 8,
      width: defaultBoxHeight - defaultPadding / 8,
      backgroundColor: backgroundColor,
      margin: margin,
      contentPadding: const EdgeInsets.all(defaultPadding / 4),
      onTap: onTap,
      onDone: onDone,
      onLongPress: onLongPress,
      child: FittedBox(child: child),
    );
  }
}
