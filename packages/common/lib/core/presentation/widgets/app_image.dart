import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImage extends StatelessWidget {
  final String imgPath;

  final double? width;
  final double? height;
  final bool isSvg;
  final Color? iconColor;
  final String? label;
  final BoxFit? boxFit;
  final String? package;
  final bool showColorFilter;
  const AppImage(
      {super.key,
      required this.imgPath,
      this.width,
      this.height,
      this.isSvg = true,
      this.iconColor,
      this.label,
      this.boxFit = BoxFit.fill,
      this.showColorFilter = true,
      this.package});

  @override
  Widget build(BuildContext context) {
    return (isSvg || imgPath.split('.').last == 'svg')
        ? SvgPicture.asset(
            imgPath,
            height: height,
            width: width,
            semanticsLabel: label,
            package: package ?? 'common',
            colorFilter: showColorFilter
                ? ColorFilter.mode(
                    iconColor ?? ColorUtils.transparent, BlendMode.srcIn)
                : null,
          )
        : Image.asset(
            imgPath,
            fit: boxFit,
            width: width,
            height: height,
            color: iconColor,
            semanticLabel: label,
            package: package ?? 'common',
          );
  }
}
