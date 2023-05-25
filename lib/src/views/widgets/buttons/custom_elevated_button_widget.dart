import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final List<BoxShadow>? boxShadow;
  final bool enable;
  final double? height;
  final double? width;
  final Duration duration;
  final double? iconHeight;
  final BoxConstraints? constraints;
  final BorderRadius borderRadius;
  final BoxBorder? border;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? margin;
  final Future<bool?>? Function()? onTap;
  final Function(bool? isSuccess)? onDone;
  final void Function()? onLongPress;
  final Widget? child;
  final Widget? onRunningWidget;
  final Widget? onSuccessWidget;
  final Widget? onErrorWidget;
  final bool expanded;
  final bool? expandedIcon;
  final MainAxisAlignment verticalAlignment;
  final AlignmentGeometry? horizontalAlignment;
  final Duration statusShowingDuration;
  final Color? backgroundColor;
  final Color iconColor;
  const CustomElevatedButton({
    super.key,
    this.height = 48,
    this.iconHeight = 24,
    this.width,
    this.constraints,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.onTap,
    this.child,
    this.onRunningWidget,
    this.expanded = false,
    this.verticalAlignment = MainAxisAlignment.center,
    this.horizontalAlignment = Alignment.center,
    this.onSuccessWidget,
    this.onErrorWidget,
    this.statusShowingDuration = const Duration(seconds: 2),
    this.onDone,
    this.backgroundColor,
    this.iconColor = Colors.white,
    this.enable = true,
    this.duration = const Duration(milliseconds: 150),
    this.margin,
    this.border,
    this.boxShadow,
    this.expandedIcon,
    this.onLongPress,
  });

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  ButtonStatus isRunning = ButtonStatus.stable;
  bool? result;

  Widget child(Widget c) {
    return Flexible(
      child: Container(
        padding: widget.iconHeight == null ? widget.contentPadding : null,
        child: SizedBox(
          height: widget.iconHeight,
          child: AspectRatio(
            aspectRatio: 1,
            child: FittedBox(
              child: c,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: widget.duration,
      child: Container(
        margin: widget.margin,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: widget.borderRadius, border: widget.border, boxShadow: widget.boxShadow, color: widget.boxShadow == null ? null : Colors.white),
        child: Material(
          color: widget.backgroundColor ?? Theme.of(context).primaryColor,
          child: InkWell(
            onLongPress: widget.onLongPress,
            onTap: !widget.enable
                ? null
                : () async {
                    if (!widget.enable) return;
                    if (isRunning != ButtonStatus.stable) return;
                    if (mounted) setState(() => isRunning = ButtonStatus.running);
                    if (widget.onTap != null) {
                      result = await widget.onTap!();
                      if (result != null) {
                        if (result! && mounted) setState(() => isRunning = ButtonStatus.success);
                        if (!result! && mounted) setState(() => isRunning = ButtonStatus.error);
                        await Future.delayed(widget.statusShowingDuration);
                      }
                    }
                    if (widget.onDone != null) widget.onDone!(result);
                    if (mounted) setState(() => isRunning = ButtonStatus.stable);
                  },
            child: Container(
              alignment: isRunning == ButtonStatus.stable
                  ? widget.expanded
                      ? widget.horizontalAlignment
                      : null
                  : widget.expandedIcon ?? widget.expanded
                      ? widget.horizontalAlignment
                      : null,
              padding: widget.contentPadding,
              height: widget.height,
              width: widget.width,
              constraints: widget.constraints,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: widget.verticalAlignment,
                children: [
                  if (isRunning == ButtonStatus.running) child(widget.onRunningWidget ?? CircularProgressIndicator(color: widget.iconColor)) else if (isRunning == ButtonStatus.success) child(widget.onSuccessWidget ?? Icon(Icons.done, color: widget.iconColor)) else if (isRunning == ButtonStatus.error) child(widget.onErrorWidget ?? Icon(Icons.error, color: widget.iconColor)) else widget.child ?? Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum ButtonStatus { stable, running, success, error }
