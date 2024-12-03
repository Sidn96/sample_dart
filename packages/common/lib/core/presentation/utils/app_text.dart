import 'package:auto_size_text/auto_size_text.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

import '../styles/font_styles.dart';

class AppText extends StatelessWidget {
  final String data;
  final double? height;
  final FontWeight? fontWeight;
  final double fontSize;
  final Color? fontColor;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final int? maxLines; //please pass maxLines from params where ever required
  final TextOverflow? overflow;
  final bool? softWrap;
  final double? letterSpacing;
  final double? minFontSize;
  final List<String>? questions;
  final double? textScaleFactor;
  final double? decorationThickness;
  final Color? backgroundColor;

  const AppText(
      {Key? key,
      required this.data,
      this.height,
      this.fontWeight,
      required this.fontSize,
      this.fontColor,
      this.textAlign,
      this.textDecoration = TextDecoration.none,
      this.maxLines,
      this.overflow,
      this.softWrap = false,
      this.letterSpacing,
      this.minFontSize,
      this.textScaleFactor,
      this.decorationThickness,
      this.backgroundColor,
      this.questions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      data,
      style: FontStyles.interStyle(
        backgroundColor: backgroundColor,
        height: height ?? 1.0,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: fontSize,
        textColor: fontColor ?? ColorUtils.blackColor,
        decoration: textDecoration ?? TextDecoration.none,
        decorationThickness: decorationThickness,
        letterSpacing: letterSpacing,
      ),
      textAlign: textAlign ?? TextAlign.center,
      textScaleFactor: textScaleFactor ?? Sizes.screenWidth() / 414,
      softWrap: true,
      maxLines: maxLines,
      overflow: overflow,
      minFontSize: minFontSize ?? fontSize - 1,
      maxFontSize: fontSize,
    );

    // Text(
    //   data,
    //   style: FontStyles.interStyle(
    //     height: height ?? 1.0,
    //     fontWeight: fontWeight ?? FontWeight.normal,
    //     fontSize: fontSize,
    //     textColor: fontColor ?? ColorUtils.blackColor,
    //     decoration: textDecoration ?? TextDecoration.none,
    //     letterSpacing: letterSpacing,
    //   ),
    //   textAlign: textAlign ?? TextAlign.center,
    //   softWrap: true,
    //   maxLines: maxLines,
    //   overflow: overflow,
    // );
  }
}
