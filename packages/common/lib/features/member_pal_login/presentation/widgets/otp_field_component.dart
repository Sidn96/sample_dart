import 'dart:io';

import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPFieldComponent extends HookWidget {
  final TextEditingController otpController;
  final Function(String)? onComplete;
  final Function(String)? onChange;
  final double? width;
  final double? height;
  final bool isSuccess;
  final bool hasError;

  const OTPFieldComponent({
    super.key,
    required this.otpController,
    this.onComplete,
    this.onChange,
    this.width,
    this.height,
    this.isSuccess = false,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    final errorController = useStreamController<ErrorAnimationType>();

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (hasError == true) {
          errorController.add(ErrorAnimationType.shake);
        }
      });
      return;
    }, [hasError]);

    return PinCodeTextField(
      autoDisposeControllers: false,
      appContext: context,
      length: 4,
      cursorColor: Colors.black,
      animationDuration: Duration.zero,
      textStyle: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
      cursorHeight: 18,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      keyboardType: !kIsWeb && Platform.isIOS
          ? const TextInputType.numberWithOptions(signed: true, decimal: true)
          : TextInputType.number,
      textInputAction: TextInputAction.done,
      enableActiveFill: true,
      pinTheme: PinTheme(
        fieldWidth: width ?? MediaQuery.of(context).size.width / 6.0,
        fieldHeight: height ?? MediaQuery.of(context).size.width / 6.0,
        fieldOuterPadding: EdgeInsets.zero,
        selectedFillColor: isSuccess
            ? ColorUtils.fieldGreenBackgroundColor
            : hasError
                ? ColorUtils.fieldRedBackgroundColor
                : ColorUtils.lightGrayColor,
        activeFillColor: isSuccess
            ? ColorUtils.fieldGreenBackgroundColor
            : hasError
                ? ColorUtils.fieldRedBackgroundColor
                : ColorUtils.lightGrayColor,
        inactiveFillColor: isSuccess
            ? ColorUtils.fieldGreenBackgroundColor
            : hasError
                ? ColorUtils.fieldRedBackgroundColor
                : ColorUtils.lightGrayColor,
        inactiveColor: isSuccess
            ? ColorUtils.fieldGreenBorderColor
            : ColorUtils.lightGrayColor,
        selectedColor: isSuccess
            ? ColorUtils.fieldGreenBorderColor
            : ColorUtils.lightGrayColor,
        activeColor: isSuccess
            ? ColorUtils.fieldGreenBorderColor
            : ColorUtils.lightGrayColor,
        errorBorderColor: ColorUtils.fieldRedBorderColor,
        activeBorderWidth: 1,
        inactiveBorderWidth: 1,
        selectedBorderWidth: 1,
        errorBorderWidth: 1,
        borderRadius: BorderRadius.circular(10.0),
        shape: PinCodeFieldShape.box,
      ),
      errorAnimationController: errorController,
      controller: otpController,
      onCompleted: onComplete,
      onChanged: onChange,
    );
  }
}
