import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyleManager {
  StyleManager._();

  /// This is the style for the header green text of the app
  static TextStyle headerTextStyle = const TextStyle(
    color: ColorUtils.blackColor,
    fontSize: 28.0,
    fontWeight: FontWeight.w800,
  );

  /// This is the style for the general black text of the app. It is customizable by providing
  /// font weight and font size parameter.
  static TextStyle blackTextStyle(
      {FontWeight fontWeight = FontWeight.w400,
        double fontSize = 16.0,
        String fontFamily = 'Ubuntu_r',
        double lineHeight = 1}) {
    return TextStyle(
        color: ColorUtils.blackColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        height: lineHeight);
  }

  /// This is the style for the general white text of the app.
  static TextStyle whiteTextStyle(
      {FontWeight fontWeight = FontWeight.w400,
        double fontSize = 16.0,
        double? lineHeight,
        TextDecoration? decoration}) {
    return TextStyle(
        color: ColorUtils.white,
        fontSize: fontSize,
        height: lineHeight,
        decoration: decoration,
        fontWeight: fontWeight);
  }

  /// This is the style for the general error text of the app.
  static TextStyle errorTextStyle(
      {FontWeight fontWeight = FontWeight.w700,
        double fontSize = 14.0,
        double? lineHeight,
        TextDecoration? decoration}) {
    return TextStyle(
        color: ColorUtils.errorColor,
        fontSize: fontSize,
        height: lineHeight,
        decoration: decoration,
        fontWeight: fontWeight);
  }

  static TextStyle errorTrueStateTextStyle() {
    return const TextStyle(
        fontWeight: FontWeight.w400,
        color: ColorUtils.errorColor,
        fontSize: Sizes.textSize12);
  }
  static TextStyle errorFalseStateTextStyle() {
    return const TextStyle(
        fontWeight: FontWeight.w400,
        color: ColorUtils.kTabDisabledTextColor,
        fontSize: Sizes.textSize12);
  }



  /// This is the style for the general text of the app.
  static TextStyle textStyle({
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 14.0,
    double? lineHeight,
    TextDecoration? decoration,
    String? fontFamily,
    Color? color,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      height: lineHeight,
      decoration: decoration,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
    );
  }

  /// This is the style for the appbar title of the app.
  static TextStyle? appBarTextStyle = TextStyle(
    color: ColorUtils.blackColor,
    fontSize: SizeConfig.safeBlockHorizontal * 4.2,
    fontFamily: 'Ubuntu_b',
  );

  static manropeStyle(
      {FontWeight? fontWeight,
        double? fontSize,
        Color? textColor,
        double? letterSpacing,
        double? height,
        TextDecoration? textDecoration}) {
    return GoogleFonts.manrope(
        fontWeight: fontWeight ?? FontWeight.w400,
        fontSize: fontSize ?? Sizes.normalTextSize,
        color: textColor ?? Colors.black,
        letterSpacing: letterSpacing ?? 0,
        height: height ?? 1,
        decoration: textDecoration);
  }

  ///Gradient for login background
  static LinearGradient bgLinearGradient() {
    return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: const [0.32, 0.6],
        colors: [Colors.white, Colors.white.withAlpha(1)]);
  }

  ///Gradient for home
  static LinearGradient homeLayLinearGradient() {
    return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.1, 0.9],
        colors: [ColorUtils.anakwaColor, ColorUtils.fadedJade]);
  }

  static interStyle(
      {FontWeight? fontWeight,
        double? fontSize,
        Color? textColor,
        double? letterSpacing,
        double? height,
        TextDecoration? textDecoration}) {
    return GoogleFonts.inter(
        fontWeight: fontWeight ?? FontWeight.w400,
        fontSize: fontSize ?? Sizes.normalTextSize,
        color: textColor ?? Colors.black,
        letterSpacing: letterSpacing ?? 0,
        height: height ?? 1,
        decoration: textDecoration);
  }



  static poppinsStyle(
      {FontWeight? fontWeight,
        double? fontSize,
        Color? textColor,
        double? letterSpacing,
        double? height,
        TextDecoration? textDecoration}) {
    return GoogleFonts.poppins(
        fontWeight: fontWeight ?? FontWeight.w400,
        fontSize: fontSize ?? Sizes.normalTextSize,
        color: textColor ?? Colors.black,
        letterSpacing: letterSpacing ?? 0,
        height: height ?? 1,
        decoration: textDecoration);
  }
}
