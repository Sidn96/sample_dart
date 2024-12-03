import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:flutter/material.dart';

class CustomUnderlineInputBorder extends MaterialStateUnderlineInputBorder {
  final Color borderColor;

  const CustomUnderlineInputBorder({this.borderColor = ColorUtils.greyLight});

  @override
  InputBorder resolve(Set<MaterialState> states) {
    return UnderlineInputBorder(borderSide: BorderSide(color: borderColor));
  }
}
