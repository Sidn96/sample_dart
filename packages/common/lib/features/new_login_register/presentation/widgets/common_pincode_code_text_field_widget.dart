import 'dart:async';

import 'package:common/features/new_login_register/presentation/widgets/common_error_timer_resend_row_widget.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CommonPinCodeTextFieldWidget extends StatelessWidget {
  final TextEditingController otpController;
  final StreamController<ErrorAnimationType>? errorAnimationController;
  final FocusNode? focusNode;
  final VoidCallback? resendCallback;
  final bool showResendOtpBlock;
  final String? otpErrorMessage;
  /// returns the current typed text in the fields
  final ValueChanged<String>? onChanged;

  /// returns the typed text when all pins are set
  final ValueChanged<String>? onCompleted;

  const CommonPinCodeTextFieldWidget({
    super.key,
    required this.otpController,
    // required this.loginRegisterPageNotifier,
    this.errorAnimationController,
    this.focusNode,
    this.resendCallback,
    this.showResendOtpBlock = false,
    this.otpErrorMessage,
    this.onChanged,
    this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        const AppText(
          data: AppConstants.enterOtpMessage,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontColor: ColorUtils.greyLight,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6, bottom: 24),
          child: PinCodeTextField(
            focusNode: focusNode,
            autoDisposeControllers: false,
            appContext: context,
            length: 4,
            controller: otpController,
            cursorColor: Colors.black,
            animationDuration: Duration.zero,
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            cursorHeight: 18,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.phone,
            pinTheme: PinTheme(
                fieldWidth: Sizes.screenWidth() * 0.16,
                inactiveColor: ColorUtils.kGreyLightColor,
                selectedColor: ColorUtils.kGreyLightColor,
                activeBorderWidth: 0.5,
                inactiveBorderWidth: 0.5,
                selectedBorderWidth: 0.5,
                shape: PinCodeFieldShape.underline,
                activeColor: ColorUtils.kGreyLightColor,
                errorBorderColor: ColorUtils.errorColor,
                errorBorderWidth: 1),
            errorAnimationController: errorAnimationController,
            onCompleted: onCompleted,
            onChanged: (value) {
              // print("OnChanged: " + value);
              onChanged?.call(value);
              // loginRegisterPageNotifier.updateOtp(value);
            },
          ),
        ),
        //Error, Timmer and Resend OTP button
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: CommonErrorTimerResendRowWidget(
              resendCallback: resendCallback,
              showWidget: showResendOtpBlock,
              errorMessage: otpErrorMessage,
            ),
          ),
        ),
      ],
    );
  }
}
