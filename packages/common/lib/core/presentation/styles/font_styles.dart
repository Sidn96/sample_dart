import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'sizes.dart';

class FontStyles {
  // static String fontFamily(BuildContext context) => tr(context).fontFamily;

  static const fontWeightBlack = FontWeight.w900;
  static const fontWeightExtraBold = FontWeight.w800;
  static const fontWeightBold = FontWeight.w700;
  static const fontWeightSemiBold = FontWeight.w600;
  static const fontWeightMedium = FontWeight.w500;
  static const fontWeightNormal = FontWeight.w400;
  static const fontWeightLight = FontWeight.w300;
  static const fontWeightExtraLight = FontWeight.w200;
  static const fontWeightThin = FontWeight.w100;

  static interStyle(
      {FontWeight? fontWeight,
      double? fontSize,
      Color? textColor,
      double? letterSpacing,
      double? height,
      double? decorationThickness,
      Color? backgroundColor,
      TextDecoration? decoration}) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        package: "common",
        fontWeight: fontWeight ?? FontWeight.w400,
        fontSize: fontSize ?? Sizes.defaultTextSize,
        color: textColor ?? Colors.black,
        decoration: decoration ?? TextDecoration.none,
        decorationThickness: decorationThickness,
        letterSpacing: letterSpacing ?? -0.02,
        height: height ?? 1,
        backgroundColor: backgroundColor,
      ),
    );
  }

  static mapSearchBarFontStyle(BuildContext context) => TextStyle(
        fontSize: Sizes.textSize16,
        color: Theme.of(context).textTheme.titleMedium!.color,
        //fontFamily: fontFamily(context),
        fontWeight: fontWeightNormal,
      );

  static poppinsStyle(
      {FontWeight? fontWeight,
      double? fontSize,
      Color? textColor,
      double? letterSpacing,
      double? height,
      TextDecoration? textDecoration}) {
    return GoogleFonts.poppins(
        textStyle: TextStyle(
      package: "common",
      fontWeight: fontWeight ?? FontWeight.w400,
      fontSize: fontSize ?? Sizes.defaultTextSize,
      color: textColor ?? Colors.black,
      decoration: textDecoration ?? TextDecoration.none,
      letterSpacing: letterSpacing ?? -0.02,
      height: height ?? 1,
    ));

    // GoogleFonts.poppins(
    //     fontWeight: fontWeight ?? FontWeight.w400,
    //     fontSize: fontSize ?? Sizes.normalTextSize,
    //     color: textColor ?? Colors.black,
    //     letterSpacing: letterSpacing ?? 0,
    //     height: height ?? 1,
    //     decoration: textDecoration);
  }
}
