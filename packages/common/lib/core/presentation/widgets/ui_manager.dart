import 'package:flutter/material.dart';

class UiManager {
  UiManager._();

  static hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  static openKeyboard() => FocusManager.instance.primaryFocus?.requestFocus();

  static double width(BuildContext context) => MediaQuery.sizeOf(context).width;

  static double height(BuildContext context) => MediaQuery.sizeOf(context).height;
  static double bottomViewInsets(BuildContext context) => MediaQuery.viewInsetsOf(context).bottom;

  static scrollToTop(ScrollController controller){
    if(controller.hasClients){
      controller.animateTo(0.0,
        curve: Curves.easeOut, duration: const Duration(milliseconds: 500),);
    }

  }
  static scrollToBottom(ScrollController controller){
    if(controller.hasClients){
      controller.animateTo(
        controller.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 500),
      );
    }
  }


}