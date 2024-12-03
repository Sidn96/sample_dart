import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/font_sizes.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:flutter/material.dart';

customToastDesign({required String msg}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 16.0),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(32)),
      color: ColorUtils.errorColor,
    ),
    child: AppText(
      data: msg,
      fontSize: FontSizes.textSize10,
      fontWeight: FontWeight.w500,
      fontColor: ColorUtils.white,
    ),
  );
}
