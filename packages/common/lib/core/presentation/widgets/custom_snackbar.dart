import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/routing/global_navigation_utils.dart';
import 'package:flutter/material.dart';

class CustomSnackbarUtil{
  //use only for root app,dont use for other pods
  static showSnackbar(String message,{Color color= ColorUtilsV2.hex_374151}){
    ScaffoldMessenger.of(
        GlobalNavigationUtils.rootAppNavigatorKey.currentContext!)
        .showSnackBar(SnackBar(
        clipBehavior: Clip.none,
        duration: const Duration(seconds: 3),
        backgroundColor: color,
        content: AppTextV2(
          data: message,
          textAlign: TextAlign.left,
          fontSize: 14.0,
          fontColor: Colors.white,
        )));
  }
}