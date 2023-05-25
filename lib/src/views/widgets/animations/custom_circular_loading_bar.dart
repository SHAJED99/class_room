import 'package:flutter/material.dart';

class CustomCircularProgressBar extends StatelessWidget {
  final Color? color;
  const CustomCircularProgressBar({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 25,
        height: 25,
        child: CircularProgressIndicator(
          color: color ?? Theme.of(context).primaryColor,
        ));
  }
}
