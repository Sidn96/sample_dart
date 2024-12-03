import 'package:common/core/presentation/styles/font_styles.dart';
import 'package:common/features/login_signup/presentation/providers/active_form_provider.dart';
import 'package:common/features/login_signup/presentation/widgets/custom_otp_field.dart';
import 'package:common/features/login_signup/presentation/widgets/mobile_number_field.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/components/otp_text_field.dart';
import '../../../../core/presentation/widgets/app_text_formfiled.dart';
import '../providers/validator.dart';

class Form2Widget extends HookConsumerWidget {
  const Form2Widget(
      {super.key,
      required this.mobileNumberController,
      required this.otpController,
      this.onResendSuccessHandler,
      this.isIndiaOnly,
      required this.emailTextEditingController,
      this.isEmailId = true,
      required this.otpCC});

  final TextEditingController mobileNumberController;
  final TextEditingController otpController;
  final Function(String)? onResendSuccessHandler;
  final bool? isIndiaOnly;
  final TextEditingController emailTextEditingController;
  final bool isEmailId;
  final OtpFieldController otpCC;

  @override
  Widget build(BuildContext context, ref) {
    final emailValidation = ref.watch(emailValidationNotifierProvider);
    final showOtp = ref.watch(showSendOtpProvider);
    final buttonText = ref.watch(enableCtaButtonTextProvider);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: isEmailId,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(height: 15),
                AppTextFormFiled(
                  labelText: "Email Id",
                  controller: emailTextEditingController,
                  labelStyle: FontStyles.interStyle(
                      height: 0.2,
                      fontWeight: FontWeight.w400,
                      fontSize: Sizes.textSize14,
                      textColor: ColorUtils.kGreyLightColor),
                  // labelText: AppConstants.loginFullName,
                  contentPadding: const EdgeInsets.only(
                      left: 2, top: 10, bottom: 10, right: 8),
                  hintText: '',
                  hintHeight: 1.3,
                  onChanged: (value) {
                    if (Validator.validateEmail(value)) {
                      ref
                          .read(emailValidationNotifierProvider.notifier)
                          .changeActiveState("");
                      if (mobileNumberController.text.isNotEmpty) {
                        ref
                            .read(enableCtaButtonProvider.notifier)
                            .changeActiveState(true);
                        ref
                            .read(enableCtaButtonTextProvider.notifier)
                            .changeActiveState(AppConstants.sendOTP);
                      }
                    } else {
                      ref
                          .read(enableCtaButtonProvider.notifier)
                          .changeActiveState(false);
                      ref
                          .read(emailValidationNotifierProvider.notifier)
                          .changeActiveState(
                              AppConstants.pleaseEnterValidEmail);
                      ref
                          .read(enableCtaButtonTextProvider.notifier)
                          .changeActiveState(AppConstants.next);
                    }
                  },
                  enableBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorUtils.kGreyBorderColor),
                  ),
                  focusBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorUtils.kGreyBorderColor),
                  ),
                  inputType: TextInputType.name,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: AppText(
                    data: emailValidation ?? "",
                    fontSize: Sizes.textSize12,
                    fontColor: ColorUtils.errorColor,
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
          MobileNumberField(
            otpController:otpController,
            isEmailId: isEmailId,
            emailTextEditingController: emailTextEditingController,
            showCountryPicker: isIndiaOnly,
            mobileNumberController: mobileNumberController,
          ),
          if (showOtp && buttonText == AppConstants.submit) ...[
            const SizedBox(height: 50),
            CustomOtpField(
              otpCC: otpCC,
              otpController: otpController,
              onResendSuccessHandler: (value) {
                if (onResendSuccessHandler != null) {
                  onResendSuccessHandler!(mobileNumberController.text);
                }
              },
            ),
          ]
        ],
      ),
    );
  }
}
