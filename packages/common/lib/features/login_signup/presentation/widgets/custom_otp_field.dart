import 'package:common/core/presentation/components/otp_text_field.dart';
import 'package:common/core/presentation/styles/font_styles.dart';
import 'package:common/features/login_signup/presentation/providers/active_form_provider.dart';
import 'package:common/features/login_signup/presentation/widgets/resend_button_and_counter.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
class CustomOtpField extends HookConsumerWidget {
  const CustomOtpField(
      {super.key, required this.otpController, this.onResendSuccessHandler,required this.otpCC});

  final TextEditingController otpController;
  final Function(String)? onResendSuccessHandler;
  final OtpFieldController otpCC;

  @override
  Widget build(BuildContext context, ref) {
    final showOptError = useState<bool>(false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //add error message gere
         const AppText(
          data: AppConstants.enterOtpMessage,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontColor: ColorUtils.greyLight,
        ),
        PinCodeTextField(
          appContext: context,
          length: 4,
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
              fieldWidth: Sizes.screenWidth()* 0.16,
              //fieldWidth: MediaQuery.sizeOf(context).width * 0.20,
              // fieldOuterPadding: const EdgeInsets.only(left:12,right: 12),
              inactiveColor: ColorUtils.kGreyLightColor,
              selectedColor: ColorUtils.kGreyLightColor,
              activeBorderWidth: 0.5,
              inactiveBorderWidth: 0.5,
              selectedBorderWidth: 0.5,
              shape: PinCodeFieldShape.underline,
              activeColor: ColorUtils.kGreyLightColor),
          controller: otpController,
          autoDisposeControllers: false,

          onCompleted: (pin) {

            otpController.text = pin;
            ref.read(enableCtaButtonProvider.notifier).changeActiveState(true);
          },
          onChanged: (value) {
            if (value.isEmpty) {
              showOptError.value = true;
            } else {
              showOptError.value = false;
            }
            if (value.length < 4) {
              ref
                  .read(enableCtaButtonProvider.notifier)
                  .changeActiveState(false);
              final showOtpErrorMsg = ref.read(sendOtpErrorNotifierProvider.notifier);
              showOtpErrorMsg.sendOtpErrorMessage("");
            }
          },
        ),
       /* OTPTextField(
          controller: otpCC,
          length: 4,
          width: MediaQuery.of(context).size.width,
          fieldWidth: 60*//*Sizes.screenWidth() * 0.2*//*,
          style: FontStyles.interStyle(
              fontSize: Sizes.textSize16, fontWeight: FontWeight.w700),
          textFieldAlignment: MainAxisAlignment.spaceAround,
          hasError: showOptError.value,
          onChanged: (value) {
            if (value.isEmpty) {
              showOptError.value = true;
            } else {
              showOptError.value = false;
            }
            if (value.length < 4) {
              ref
                  .read(enableCtaButtonProvider.notifier)
                  .changeActiveState(false);
              final showOtpErrorMsg = ref.read(sendOtpErrorNotifierProvider.notifier);
              showOtpErrorMsg.sendOtpErrorMessage("");
            }
          },
          onCompleted: (pin) {
            otpController.text = pin;
            ref.read(enableCtaButtonProvider.notifier).changeActiveState(true);
          },
        ),*/
        const SizedBox(height: 5),
        ResendButtonAndCounter(
          otpController: otpController,
          otpcc: otpCC,
          showOptError: showOptError,
          onResendSuccessHandler: onResendSuccessHandler,
        ),
      ],
    );
  }
}
