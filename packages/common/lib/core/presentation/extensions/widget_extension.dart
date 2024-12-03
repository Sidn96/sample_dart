import 'package:flutter/material.dart';

import '../styles/color_utils.dart';

filledButtonStyle({Color? backgroundColor, double? radius, double? elevation}) {
  return ElevatedButton.styleFrom(
      elevation: elevation ?? 2,
      backgroundColor: backgroundColor ?? ColorUtils.kBlueColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 4))));
}

unfilledButtonStyle({Color? outlineColor, double? radius,double? elevation}) {
  return ElevatedButton.styleFrom(
    surfaceTintColor:Colors.white ,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 4))),
    side: BorderSide(
        color: outlineColor ?? ColorUtils.kBlueColor,
        width: 1,
        style: BorderStyle.solid),
  );
}
