import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({
    super.key,
    required this.productList,
    required this.onBuild,
    this.decoration,
    this.carouselMargin,
    this.clipBehavior = Clip.antiAlias,
    this.dotBorder,
    this.carouselHeight = 144,
    this.autoPlayAnimationDurationMilliSeconds = 450,
    this.borderRadius,
    this.dotPadding,
    this.dotHeight = 4,
    this.dotWidth = 4,
    this.dotColor = Colors.grey,
    this.selectedDotColor = Colors.white,
    this.dotPositionTop,
    this.dotPositionBottom = 0,
    this.dotPositionLeft = 0,
    this.dotPositionRight = 0,
    this.aspectRatio,
    this.autoPlay = false,
  });
  final List productList;
  final Widget Function(MapEntry<int, dynamic> element) onBuild;
  final Decoration? decoration;
  final EdgeInsetsGeometry? carouselMargin;
  final Clip clipBehavior;
  final BoxBorder? dotBorder;
  final double carouselHeight;
  final int autoPlayAnimationDurationMilliSeconds;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? dotPadding;
  final double dotHeight;
  final double dotWidth;
  final Color dotColor;
  final Color selectedDotColor;
  final double? dotPositionTop;
  final double? dotPositionBottom;
  final double? dotPositionLeft;
  final double? dotPositionRight;
  final double? aspectRatio;

  final bool autoPlay;
  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  final CarouselController carouselController = CarouselController();

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          clipBehavior: widget.clipBehavior,
          margin: widget.carouselMargin,
          decoration: widget.decoration ?? BoxDecoration(borderRadius: widget.borderRadius),
          child: CarouselSlider(
            carouselController: carouselController,
            options: CarouselOptions(
              aspectRatio: widget.aspectRatio ?? 16 / 9,
              initialPage: _index,
              height: widget.aspectRatio == null ? widget.carouselHeight : null,
              viewportFraction: 1,
              autoPlay: widget.autoPlay,
              autoPlayAnimationDuration: Duration(milliseconds: widget.autoPlayAnimationDurationMilliSeconds),
              onPageChanged: (index, reason) => {if (mounted) setState(() => _index = index)},
            ),
            items: widget.productList.asMap().entries.map((e) => widget.onBuild(e)).toList(),
          ),
        ),
        // Dot
        Positioned(
          top: widget.dotPositionTop,
          bottom: widget.dotPositionBottom,
          left: widget.dotPositionLeft,
          right: widget.dotPositionRight,
          child: Align(
            alignment: Alignment.center,
            widthFactor: 1,
            heightFactor: 1,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: widget.productList.asMap().entries.map((e) {
                return Container(
                  margin: widget.dotPadding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 1),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: widget.dotBorder,
                  ),
                  child: ClipOval(
                    child: Material(
                      color: e.key == _index.toInt() ? widget.selectedDotColor : widget.dotColor,
                      child: InkWell(
                        onTap: () => carouselController.animateToPage(e.key),
                        child: SizedBox(
                          width: widget.dotWidth,
                          height: widget.dotHeight,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
