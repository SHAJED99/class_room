import 'package:class_room/app_constants.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    this.link,
    this.fit = BoxFit.cover,
    this.color = defaultWhiteColor,
  });
  final String? link;
  final BoxFit? fit;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      link ?? "",
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) => Stack(
        children: [
          Positioned.fill(
            child: LinearProgressIndicator(
              color: color.withOpacity(0.5),
            ),
          ),
        ],
      ),
      errorBuilder: (context, error, stackTrace) => FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 1,
        child: FittedBox(
          child: Icon(
            Icons.error,
            color: color,
          ),
        ),
      ),
    );
  }
}
