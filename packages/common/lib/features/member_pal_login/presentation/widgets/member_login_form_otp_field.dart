import 'dart:io';

import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/features/member_pal_login/presentation/providers/member_signup_login_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPInputField extends HookConsumerWidget {
  final Function(String)? onComplete;
  final TextEditingController otpController;
  final double? fieldWidth;
  const OTPInputField(
      {super.key,
      required this.otpController,
      this.onComplete,
      this.fieldWidth});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorController = useStreamController<ErrorAnimationType>();
    final showOtpError = ref.watch(showMemberPalOtpErrorProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (showOtpError == true) {
          errorController.add(ErrorAnimationType.shake);
        }
      });
      return;
    }, [showOtpError]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          data: "Enter OTP",
          fontColor: ColorUtilsV2.hex_9CA3AF,
          fontWeight: FontWeight.w400,
          fontSize: 12,
          letterSpacing: 0.24,
        ),
        10.height,
        PinCodeTextField(
          autoDisposeControllers: false,
          appContext: context,
          length: 4,
          cursorColor: Colors.black,
          animationDuration: Duration.zero,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          cursorHeight: 18,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          keyboardType: !kIsWeb && Platform.isIOS
              ? const TextInputType.numberWithOptions(
                  signed: true, decimal: true)
              : TextInputType.number,
          textInputAction: TextInputAction.done,
          pinTheme: PinTheme(
            fieldWidth: fieldWidth ?? Sizes.screenWidth() * 0.20,
            fieldHeight: 56,
            // fieldWidth: Sizes.screenWidth() * 0.18,
            //fieldWidth: MediaQuery.sizeOf(context).width * 0.20,
            // fieldOuterPadding: const EdgeInsets.only(left:12,right: 12),
            inactiveColor: ColorUtils.kGreyLightColor,
            selectedColor: ColorUtils.kGreyLightColor,
            activeBorderWidth: 1,
            inactiveBorderWidth: 1,
            selectedBorderWidth: 1,
            borderRadius: BorderRadius.circular(6.0),
            shape: PinCodeFieldShape.box,
            activeColor: ColorUtils.ffC2C2C9,
            errorBorderColor: ColorUtils.errorColor,
            errorBorderWidth: 1,
          ),
          errorAnimationController: errorController,
          controller: otpController,
          onCompleted: (pin) async {
            ref.read(memberSignUpLoginProvierProvider.notifier).setOtp(pin);
            onComplete?.call(pin);
          },
          onChanged: (value) {
            if (value.length < 4) {
              ref.read(memberSignUpLoginProvierProvider.notifier).setOtp("");
              ref
                  .read(showMemberPalOtpErrorProvider.notifier)
                  .changeState(false);
            }
          },
        ),
      ],
    );
  }
}
