import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToastBox(BuildContext context,
    {required String message,
    ToastStatus status = ToastStatus.defaultt,
    Duration? toastDuration}) {
  late FToast fToast = FToast().init(context);
  Color bgColor(ToastStatus status) {
    switch (status) {
      case ToastStatus.success:
        return ColorUtils.kGreenBrightColor;
      case ToastStatus.error:
        return ColorUtils.errorColor;
      case ToastStatus.defaultt:
        return ColorUtils.snackbarBlack;
    }
  }

  Color txtColor(ToastStatus status) {
    switch (status) {
      case ToastStatus.success:
      case ToastStatus.error:
        return ColorUtils.bluishblack;
      case ToastStatus.defaultt:
        return ColorUtils.white2;
    }
  }

  return fToast.showToast(
      child: Container(
          width: Sizes.screenWidth() * 0.9,
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: bgColor(status),
          ),
          child: AppText(
            data: message,
            fontSize: 12,
            height: 1.4,
            fontWeight: FontWeight.w600,
            fontColor: txtColor(status),
          )),
      gravity: ToastGravity.BOTTOM,
      toastDuration: toastDuration ?? const Duration(seconds: 2),
      positionedToastBuilder: (context, child) {
        return Positioned(
          bottom: 120.0,
          left: 0,
          right: 0,
          child: child,
        );
      });
}

enum ToastStatus { success, error, defaultt }
