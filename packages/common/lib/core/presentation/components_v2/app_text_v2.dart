import 'package:common/core/presentation/components_v2/text_styles.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AppTextV2 extends StatelessWidget {
  final String data;
  final double? height;
  final FontWeight? fontWeight;
  final double fontSize;
  final Color? fontColor;
  final Color? backgroundColor;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final int? maxLines; //please pass maxLines from params where ever required
  final TextOverflow? overflow;
  final double? letterSpacing;
  final double? minFontSize;
  final TextStyle? textStyle;
  final Color? decorationColor;
  final double? decorationThickness;

  const AppTextV2(
      {Key? key,
      required this.data,
      this.height,
      this.fontWeight = FontWeight.w400,
      required this.fontSize,
      this.fontColor,
      this.textAlign,
      this.textDecoration,
      this.maxLines,
      this.overflow,
      this.letterSpacing,
      this.minFontSize,
      this.textStyle,
      this.decorationColor,
      this.backgroundColor,
      this.decorationThickness})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      data,
      style: textStyle ??
          TextStyles.manropeStyle(fontSize,
              height: height,
              fontWeight: fontWeight,
              color: fontColor,
              decoration: textDecoration,
              letterSpacing: letterSpacing,
              backgroundColor: backgroundColor,
              decorationColor: decorationColor,
              decorationThickness: decorationThickness),
      textAlign: textAlign ?? TextAlign.center,
      textScaleFactor: Sizes.screenWidth() / 414,
      softWrap: true,
      maxLines: maxLines,
      overflow: overflow,
      minFontSize: minFontSize ?? fontSize - 1,
      maxFontSize: fontSize,
    );
  }
}

class AppTextWithoutAutoSize extends StatelessWidget {
  final String data;
  final double? height;
  final FontWeight? fontWeight;
  final double fontSize;
  final Color? fontColor;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final int? maxLines; //please pass maxLines from params where ever required
  final TextOverflow? overflow;
  final double? letterSpacing;
  final double? minFontSize;
  final TextStyle? textStyle;

  const AppTextWithoutAutoSize({
    Key? key,
    required this.data,
    this.height,
    this.fontWeight = FontWeight.w400,
    required this.fontSize,
    this.fontColor,
    this.textAlign,
    this.textDecoration,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.minFontSize,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: textStyle ??
          TextStyles.manropeStyle(
            fontSize,
            height: height,
            fontWeight: fontWeight,
            color: fontColor,
            decoration: textDecoration,
            letterSpacing: letterSpacing,
          ),
      textAlign: textAlign ?? TextAlign.center,
      softWrap: true,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
