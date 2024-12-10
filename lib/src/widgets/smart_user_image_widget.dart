import 'package:flutter/material.dart';
import 'package:main_widgets/main_widgets.dart';
import 'package:main_widgets/src/extension/initials_extension.dart';

class SmartUserImageWidget extends StatelessWidget {
  final String? photo;
  final String displayName;
  final TextStyle? style;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? size;

  const SmartUserImageWidget({
    super.key,
    this.photo,
    required this.displayName,
    this.style,
    this.backgroundColor,
    this.borderColor,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return photo == null
        ? DefaultProfileImage(
            displayName: displayName,
            backgroundColor: backgroundColor,
            size: size,
            borderColor: borderColor,
            style: style,
          )
        : CircleImageWidget(
            photo: photo,
            size: size,
            errorWidget: DefaultProfileImage(
              displayName: displayName,
              backgroundColor: backgroundColor,
              size: size,
              borderColor: borderColor,
              style: style,
            ),
          );
  }
}

class DefaultProfileImage extends StatelessWidget {
  final String displayName;
  final TextStyle? style;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? size;

  const DefaultProfileImage({
    super.key,
    required this.displayName,
    this.backgroundColor,
    this.borderColor,
    this.style,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 42,
      height: size ?? 42,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor ?? Colors.grey.shade300,
          width: 0.5,
        ),
        color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      ),
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          displayName.initials,
          style: style ??
              context.titleSmall?.copyWith(
                color: Theme.of(context).primaryColor,
              ),
        ),
      ),
    );
  }
}

class CircleImageWidget extends StatelessWidget {
  final double? size;
  final String? photo;
  final Widget? errorWidget;

  const CircleImageWidget({
    super.key,
    this.size,
    this.photo,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 28,
      height: size ?? 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300, width: 0.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: SmartCachedImages(
        imageUrl: '$photo',
        width: size,
        height: size,
        errorWidget: errorWidget ?? const Icon(Icons.error),
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
