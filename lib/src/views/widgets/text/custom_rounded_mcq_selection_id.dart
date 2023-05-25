import 'package:class_room/app_constants.dart';
import 'package:flutter/material.dart';

class CustomRoundedMCQSelectionId extends StatelessWidget {
  final int id;
  final bool? isActive;
  const CustomRoundedMCQSelectionId(this.id, {super.key, this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isActive ?? false ? Theme.of(context).primaryColor : null,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          width: 2,
          color: Theme.of(context).primaryColor,
        ),
      ),
      height: defaultBoxHeight / 2,
      width: defaultBoxHeight / 2,
      alignment: Alignment.center,
      child: FittedBox(
        child: Text(
          id.toString(),
          style: buttonText1.copyWith(
            color: isActive ?? false ? defaultWhiteColor : Theme.of(context).primaryColor,
            height: 0,
          ),
        ),
      ),
    );
  }
}
