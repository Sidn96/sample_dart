import 'dart:async';
import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/components_v2/error_timer_resend_row_widget.dart';
import 'package:common/core/presentation/components_v2/text_styles.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeTextFieldWidget extends StatelessWidget {
  final TextEditingController otpController;
  final StreamController<ErrorAnimationType>? errorAnimationController;
  final FocusNode? focusNode;
  final VoidCallback? resendCallback;

  final ValueChanged<String>? onChanged;
  final ValueNotifier<ErrorTimerResendData> errorTimerValueNotifier;

  const PinCodeTextFieldWidget(
      {super.key,
      required this.otpController,
      this.errorAnimationController,
      this.focusNode,
      required this.resendCallback,
      this.onChanged,
      required this.errorTimerValueNotifier
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      // alignment: AlignmentDirectional.topStart,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 2),
          child: AppTextV2(
            data: 'OTP',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontColor: ColorUtilsV2.hex_717182,
          ),
        ),
        PinCodeTextField(
          focusNode: focusNode,
          autoDisposeControllers: false,
          appContext: context,
          length: 4,
          controller: otpController,
          cursorColor: ColorUtilsV2.hex_35354D,
          animationDuration: Duration.zero,
          textStyle: TextStyles().mediumStyle(16, color: ColorUtilsV2.hex_35354D),
          cursorHeight: 16,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          keyboardType: TextInputType.phone,
          pinTheme: PinTheme(
            fieldWidth: Sizes.screenWidth() * 0.20,
            inactiveColor: ColorUtilsV2.specialNeutral300,
            selectedColor: ColorUtilsV2.specialNeutral300,
            activeBorderWidth: 1,
            inactiveBorderWidth: 1,
            selectedBorderWidth: 1,
            shape: PinCodeFieldShape.box,
            activeColor: ColorUtilsV2.specialNeutral300, // once input entered
            errorBorderColor: ColorUtilsV2.hex_F87171,
            errorBorderWidth: 1,
            fieldOuterPadding: const EdgeInsets.only(top: 6, bottom: 12),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
          errorAnimationController: errorAnimationController,
          onCompleted: (pin) {},
          onChanged: onChanged,
        ),
        //Error, Timmer and Resend OTP button
        ErrorTimerResendRowWidget(
          resendCallback: resendCallback,
          valueNotifier: errorTimerValueNotifier,
        ),
      ],
    );
  }
}
