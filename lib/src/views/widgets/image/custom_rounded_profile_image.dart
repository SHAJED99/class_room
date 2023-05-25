import 'package:class_room/src/views/widgets/buttons/custom_rounded_button.dart';
import 'package:flutter/material.dart';

class CustomRoundedProfileImageWidget extends StatelessWidget {
  final String? link;
  final Function? onTap;
  const CustomRoundedProfileImageWidget({
    super.key,
    this.link,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomRoundedButton(
      onTap: () async {
        if (onTap != null) onTap!();
        return;
      },
      child: CircleAvatar(
        backgroundColor: Theme.of(context).canvasColor,
        foregroundImage: NetworkImage(link ?? ""),
        onForegroundImageError: (exception, stackTrace) => const Icon(
          Icons.error,
          color: Colors.amber,
        ),
      ),
    );
  }
}
