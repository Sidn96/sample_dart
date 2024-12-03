import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/font_styles.dart';
import 'package:flutter/material.dart';

InputDecoration textFieldLightGreyDecoration({
  String? label,
  String? hintText,
  Widget? prefixWidget,
  Widget? sufixWidget,
  Widget? sufixIcon,
  String? errorText,
  double? hintTextSize,
  double? hintTextHeight,
  FloatingLabelBehavior? floatingLabelBehavior,
  EdgeInsetsGeometry? contentPadding,
  Widget? prefixIcon,
  Color? hintTextColor,
  Color? fillColor,
  Color? labelColor,
  required Color enableBorderColor,
  required Color focusedBorderColor,
  required Color disableBorderColor,
  // required Color errorBorderColor,
}) {
  return InputDecoration(
    floatingLabelBehavior: floatingLabelBehavior,
    contentPadding: contentPadding ?? const EdgeInsets.all(18),
    fillColor: fillColor,
    prefixIcon: prefixIcon,
    filled: fillColor != null,
    errorStyle: FontStyles.interStyle(
      textColor: ColorUtilsV2.hex_F87171,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
    hintStyle: FontStyles.interStyle(
      textColor: hintTextColor ?? ColorUtils.neutralGrey,
      fontSize: hintTextSize ?? 16,
      height: hintTextHeight ?? 1.2,
      fontWeight: FontWeight.w400,
    ),
    labelStyle: FontStyles.interStyle(
      textColor: labelColor ?? ColorUtils.neutralGrey,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    floatingLabelStyle: FontStyles.interStyle(
      textColor: labelColor ?? ColorUtils.midLightGrey,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: BorderSide(color: enableBorderColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: BorderSide(color: enableBorderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: BorderSide(color: focusedBorderColor),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: const BorderSide(color: ColorUtilsV2.hex_F87171),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: const BorderSide(color: ColorUtilsV2.hex_F87171),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: BorderSide(color: disableBorderColor),
    ),
    hintText: hintText ?? (label != null ? "Enter $label" : ""),
    labelText: label,
    prefix: prefixWidget,
    suffix: sufixWidget,
    suffixIcon: sufixIcon,
    errorText: errorText,
  );
}
