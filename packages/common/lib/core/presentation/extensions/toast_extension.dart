import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:flutter/material.dart';

import '../styles/color_utils.dart';
import '../styles/sizes.dart';
import '../utils/app_text.dart';

customToastDesign({
  required String msg,

}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 16.0),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(32)),
      color: ColorUtils.errorColor,
    ),
    child: AppText(
      data: msg,
      fontSize: Sizes.textSize10,
      fontWeight: FontWeight.w500,
      fontColor: ColorUtils.white,
    ),
  );
}

insuranceCustomToastDesign({required String msg}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20.0),
    padding: const EdgeInsets.all(10),
    width: double.infinity,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      color: ColorUtilsV2.hex_F87171,
    ),
    child: AppTextV2(
      data: msg,
      fontSize: Sizes.textSize12,
      fontWeight: FontWeight.w500,
      fontColor: Colors.white,
      height: 18 / 12,
    ),
  );
}
