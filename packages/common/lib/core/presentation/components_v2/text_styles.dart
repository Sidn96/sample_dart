import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static final TextStyles instance = TextStyles._();
  static const _fontFamily = 'Manrope';
  static const _package = 'common';

  TextStyles._();

  factory TextStyles() {
    return instance;
  }

  static TextStyle manropeStyle(double fontSize,
      {FontWeight? fontWeight = FontWeight.w400,
      Color? color,
      // Color? color = Colors.black,
      double? letterSpacing,
      double? height = 1,
      TextDecoration? decoration = TextDecoration.none,
      Color? decorationColor,
      Color? backgroundColor,
      double? decorationThickness}) {
    return GoogleFonts.manrope(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        letterSpacing: letterSpacing,
        decoration: decoration,
        backgroundColor: backgroundColor,
        height: height,
        decorationColor: decorationColor,
        decorationThickness: decorationThickness ?? 1.0);
  }

  TextStyle extraLightStyle(
    double fontSize, {
    Color color = Colors.black,
    TextDecoration decoration = TextDecoration.none,
    double height = 1,
  }) {
    return manropeStyle(
      fontSize,
      fontWeight: FontWeight.w200,
      color: color,
      letterSpacing: (fontSize * -2) / 100,
      height: height,
      decoration: decoration,
    );
  }

  TextStyle lightStyle(
    double fontSize, {
    Color? color,
    TextDecoration decoration = TextDecoration.none,
    double height = 1,
  }) {
    return manropeStyle(
      fontSize,
      fontWeight: FontWeight.w300,
      color: color,
      letterSpacing: (fontSize * -2) / 100,
      height: height,
      decoration: decoration,
    );
  }

  TextStyle regularStyle(
    double fontSize, {
    Color? color,
    TextDecoration decoration = TextDecoration.none,
    double height = 1,
  }) {
    return manropeStyle(fontSize,
        fontWeight: FontWeight.w400,
        color: color,
        letterSpacing: (fontSize * -2) / 100,
        height: height,
        decoration: decoration);
  }

  TextStyle mediumStyle(
    double fontSize, {
    Color? color,
    TextDecoration decoration = TextDecoration.none,
    double height = 1,
  }) {
    return manropeStyle(fontSize,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: (fontSize * -2) / 100,
        height: height,
        decoration: decoration);
  }

  TextStyle semiBoldStyle(
    double fontSize, {
    Color color = Colors.black,
    TextDecoration decoration = TextDecoration.none,
    double height = 1,
  }) {
    return manropeStyle(fontSize,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: (fontSize * -2) / 100,
        height: height,
        decoration: decoration);
  }

  TextStyle boldStyle(
    double fontSize, {
    Color color = Colors.black,
    TextDecoration decoration = TextDecoration.none,
    double height = 1,
  }) {
    return manropeStyle(fontSize,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: (fontSize * -2) / 100,
        height: height,
        decoration: decoration);
  }

  TextStyle extraBoldStyle(
    double fontSize, {
    Color color = Colors.black,
    TextDecoration decoration = TextDecoration.none,
    double height = 1,
  }) {
    return manropeStyle(fontSize,
        fontWeight: FontWeight.w800,
        color: color,
        letterSpacing: (fontSize * -2) / 100,
        height: height,
        decoration: decoration);
  }

  String getFontFamily() => _fontFamily;

  String getPackage() => _package;
}
