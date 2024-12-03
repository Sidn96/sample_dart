import 'dart:async';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/components_v2/text_styles.dart';
import 'package:common/core/presentation/utils/extensions/string_extension.dart';
import 'package:common/features/new_login_register/presentation/notifiers/login_register_page_status_notifier.dart';
import 'package:common/features/new_login_register/presentation/widgets/error_timer_resend_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// same as PinCodeTextFieldWidget in NPS-customer details
class PinCodeTextFieldWidget extends StatelessWidget {
  final TextEditingController otpController;
  final StreamController<ErrorAnimationType>? errorAnimationController;
  final LoginRegisterPageNotifier loginRegisterPageNotifier;
  final FocusNode? focusNode;
  final VoidCallback? resendCallback;
  final Color? otpLabelColor;
  final Color? otpTextColor;
  final Color? otpCursorColor;
  final Color? resendEnableColor;
  final Color? resendDisableColor;
  final Color? otpTimerColor;
  final double? otpFieldWidthInPercent;
  final AnimationController slideAnimationController;
  final Color? changeCTAColor;
  final Color? otpSentMsgColor;
  final bool showDecorationOnCTAs;

  // final bool showResendOtpBlock;
  // final String? otpErrorMessage;

  const PinCodeTextFieldWidget(
      {super.key,
      required this.otpController,
      required this.loginRegisterPageNotifier,
      this.errorAnimationController,
      this.focusNode,
      this.resendCallback,
      this.otpLabelColor,
      this.otpTextColor,
      this.otpCursorColor,
      this.resendEnableColor,
      this.resendDisableColor,
      this.otpTimerColor,
      this.otpFieldWidthInPercent = 0.20,
      required this.slideAnimationController,
      this.changeCTAColor = ColorUtilsV2.hex_4E52F8,
      this.otpSentMsgColor,
      this.showDecorationOnCTAs = false
      // this.showResendOtpBlock = false,
      // this.otpErrorMessage,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      // alignment: AlignmentDirectional.topStart,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // AppTextV2(
        //   data: AppConstants.otp,
        //   fontSize: 12,
        //   fontWeight: FontWeight.w400,
        //   fontColor: otpLabelColor ?? ColorUtilsV2.hex_717182,
        // ),
        SlideTransition(
          position: CurvedAnimation(
                  parent: slideAnimationController,
                  curve: Curves.decelerate // Add Curves.easeIn curve here
                  )
              .drive(
            Tween<Offset>(
              begin: const Offset(1.0, 0.0), // Offscreen to the right
              end: const Offset(0.0, 0.0), // Centered
            ),
          ),
          child: PinCodeTextField(
            focusNode: focusNode,
            autoDisposeControllers: false,
            appContext: context,
            length: 4,
            controller: otpController,
            cursorColor: otpCursorColor ?? ColorUtilsV2.hex_35354D,
            animationDuration: Duration.zero,
            textStyle: TextStyles().mediumStyle(16,
                color: otpTextColor ?? ColorUtilsV2.hex_35354D),
            cursorHeight: 16,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.phone,
            pinTheme: PinTheme(
              fieldWidth: MediaQuery.sizeOf(context).width *
                  (otpFieldWidthInPercent ?? 0.20),
              inactiveColor: ColorUtilsV2.specialNeutral300,
              selectedColor: ColorUtilsV2.specialNeutral300,
              activeBorderWidth: 1,
              inactiveBorderWidth: 1,
              selectedBorderWidth: 1,
              shape: PinCodeFieldShape.box,
              activeColor: ColorUtilsV2.specialNeutral300,
              // once input entered
              errorBorderColor: ColorUtilsV2.hex_F87171,
              errorBorderWidth: 1,
              fieldOuterPadding: const EdgeInsets.only(top: 6, bottom: 12),
              borderRadius: const BorderRadius.all(Radius.circular(6)),
            ),
            errorAnimationController: errorAnimationController,
            onCompleted: (pin) {},
            onChanged: (value) {
              // print("OnChanged: " + value);
              if (value.isNotNullNorEmpty()) {
                loginRegisterPageNotifier.updateOtp(value);
              }
            },
          ),
        ),
        //Error, Timmer and Resend OTP button
        ErrorTimerResendRowWidget(
          resendCallback: resendCallback,
          resendEnableColor: resendEnableColor,
          resendDisableColor: resendDisableColor,
          otpTimerColor: otpTimerColor,
          changeCTAColor: changeCTAColor,
          otpSentMsgColor: otpSentMsgColor,
          showDecorationOnCTAs: showDecorationOnCTAs,
        ),
      ],
    );
  }
}
