import 'package:flutter/material.dart';

import '../../color_utils_v2.dart';
import '../../text_styles.dart';

class TextFormHelper{
  static final TextFormHelper instance = TextFormHelper._internal();

  TextFormHelper._internal();
  Color errorColor = ColorUtilsV2.specialDestructive400;

  factory TextFormHelper() => instance;

  static InputBorder defaultOutlineInputBorder({double width = 1, Color color = ColorUtilsV2.specialNeutral300, String? errorText,}){
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      borderSide: BorderSide(width: width, color: errorText == null ? color : ColorUtilsV2.specialDestructive400,),
      gapPadding: 4,
    );
  }
  static InputBorder defaultEnabledOutlineInputBorder({double width = 1, Color? color, String? errorText,}){
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      borderSide: BorderSide(width: width, color: errorText == null ? (color ?? ColorUtilsV2.specialNeutral300) : ColorUtilsV2.specialDestructive400,),
      gapPadding: 4,
    );
  }
  static InputBorder defaultDisabledOutlineInputBorder({double width = 1, Color color = ColorUtilsV2.specialNeutral300}){
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      borderSide: BorderSide(width: width, color: color),
      gapPadding: 4,
    );
  }
  static InputBorder defaultFocusedOutlineInputBorder({double width = 1, String? errorText,}){
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      borderSide: BorderSide(width: width, color: errorText == null ? ColorUtilsV2.specialNeutral300 : ColorUtilsV2.specialDestructive400,),
      gapPadding: 4,
    );
  }
  static InputBorder defaultErrorOutlineInputBorder({double width = 1, Color color = ColorUtilsV2.specialDestructive400, String? errorText,}){
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      borderSide: BorderSide(width: width, color: errorText == null ? color : ColorUtilsV2.specialDestructive400),
      gapPadding: 4,
    );
  }

  static TextStyle hintStyle(){
    return TextStyles().regularStyle(
      14,
      color: ColorUtilsV2.hex_717182,
      height: 0.05,
    );
  }

  static TextStyle labelStyle({String? errorText, Color? color = ColorUtilsV2.hex_717182}){
    return TextStyles.manropeStyle(
      14,
      fontWeight: FontWeight.w400,
      color: errorText == null ? color : ColorUtilsV2.specialDestructive400,
      height: 0.05,
    );
  }
  static TextStyle errorStyle(){
    return TextStyles().mediumStyle(
      10,
      color: ColorUtilsV2.specialDestructive400,
      height: 0,
    );
  }
  static TextStyle defaultTextStyle({double? fontSize, Color? defaultColor, String? errorText, double? textLineHeight = 0, FontWeight fontWeight =FontWeight.w500 }){
    return TextStyles.manropeStyle(
      fontSize ?? 16,
      fontWeight: fontWeight,
      height: textLineHeight,
      letterSpacing: -0.32,
      color: errorText == null
          ? (defaultColor ?? ColorUtilsV2.specialNeutral700)
          : ColorUtilsV2.specialDestructive400,
    );
  }
}