import 'package:common/core/presentation/components/phoneNo_text_field_country.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/font_styles.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:common/core/presentation/widgets/app_text_formfiled.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:common/core/presentation/components/phoneNo_text_field.dart';
import 'package:common/core/presentation/components/otp_field.dart';

import '../../domain/usecase_error.dart';
import '../providers/notifiers/login_notifiers.dart';
import '../providers/notifiers/otp_notifier.dart';
import '../providers/notifiers/phone_num_validator_notifier.dart';
import 'new_phoneNo_textfield.dart';

class LoginFormScreen extends HookConsumerWidget {
  final String apisource;
  final String path;
  final bool fullNameWidget;
  final String? numberHeaderName;
  final ValueNotifier<String?>? invalidOtp;
  final bool isIndiaFlag;
  final Widget? prefixIcon;

  const LoginFormScreen(
      {super.key,
      required this.apisource,
      this.prefixIcon,
      this.invalidOtp,
      this.isIndiaFlag = false,
      required this.path,
      this.fullNameWidget = true,
      this.numberHeaderName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneValidationNotifier =
        ref.watch(phoneNoValidationNotifierProvider.notifier);

    final rcAOELoginNotifier =
        ref.watch(sendMobileOtpNotifierProvider.notifier);

    final resendColorValue = ref.watch(changeResendColorProvider);

    final showOTPField = ref.read(toShowOTPFieldProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: fullNameWidget,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19.0),
                child: AppTextFormFiled(
                  controller: rcAOELoginNotifier.fullNameController,
                  labelStyle: FontStyles.interStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: Sizes.textSize12,
                    textColor: ColorUtils.kGreyLightColor,
                  ),
                  contentPadding: const EdgeInsets.only(
                      left: 8, top: 8, bottom: 12, right: 8),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]')),
                  ],
                  labelText: AppConstants.loginFullName,
                  hintText: '',
                  onChanged: (value) {
                    ref
                        .read(fullNameValidateNotifierProvider.notifier)
                        .validateFullName(value);
                  },
                  inputType: TextInputType.name,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  top: 8.0,
                ),
                child: AppText(
                  data: ref.watch(getFullNameErrorMsgProvider),
                  fontSize: Sizes.textSize12,
                  fontColor: ColorUtils.errorColor,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0,right: 16.0),
          child: NewPhoneNoTextField(showLabelText: true,headerValue: AppConstants.mobileNo,
            enableBottomSpacing: false,
            contentPadding: const EdgeInsets.only(bottom: 9.5),
            phoneNoController: rcAOELoginNotifier.phoneNoController,
            onChanged: (value) {
              phoneValidationNotifier.validatePhoneNo(value);
            },
          ),
        ),
        /*PhoneNoTextFieldCommon(
          isIndiaFlag: isIndiaFlag,
          prefixIcon: prefixIcon,
          numberHeaderName: numberHeaderName ?? AppConstants.mobileNo,
          showLabelText: true,
          phoneNoController: rcAOELoginNotifier.phoneNoController,
          onChanged: (value) {
            phoneValidationNotifier.validatePhoneNo(value);
          },
         */ /* contentPadding:
              const EdgeInsets.only(left: 8, top: 8, bottom: 0, right: 8),*/ /*
          enableBottomSpacing: false,
        ),*/
        Padding(
          padding: const EdgeInsets.only(left: 17.0, top: 8.0, bottom: 8.0),
          child: AppText(
            data: ref.watch(unauthorizedNotifierProvider) ??
                ref.watch(getPhoneErrorMsgProvider),
            fontSize: Sizes.textSize12,
            fontColor: (ref.watch(getPhoneErrorMsgProvider) ==
                        AppUseCasesErrors.getAnOTP &&
                    ref.watch(unauthorizedNotifierProvider) == null)
                ? ColorUtils.kYellowColor
                : ColorUtils.errorColor,
            textAlign: TextAlign.start,
          ),
        ),
        ref.watch(isLoadingProvider)
            ? const Center(
                child: Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: CircularProgressIndicator(),
              ))
            : Visibility(
                visible: ref.watch(unauthorizedNotifierProvider) == null
                    ? showOTPField
                    : false,
                child: OTPField(
                  invalidOtp: invalidOtp,
                  resendColorChange: resendColorValue,
                  otpFieldController: rcAOELoginNotifier.otpFieldController,
                  onChanged: (value) {
                    ref
                        .read(oTPValidationNotifierProvider.notifier)
                        .validateOTP(value);
                    invalidOtp!.value = "";
                  },
                  errorText: ref.watch(getOTPVerifyMsgProvider),
                  timerCount: ref.watch(resendOTPTimerNotifierProvider),
                  onResendClick: () {
                    invalidOtp!.value = null;
                    if (ref.read(changeResendColorProvider)) {
                      rcAOELoginNotifier.otpFieldController?.clear();
                      ref
                          .read(resendOTPTimerNotifierProvider.notifier)
                          .resetOTPTimer();
                      ref
                          .read(oTPValidationNotifierProvider.notifier)
                          .validateOTP("");
                      ref
                          .read(sendMobileOtpNotifierProvider.notifier)
                          .sendMobileOtpApi(apisource, path);
                    } else {}
                  },
                  onCompleted: (pin) {
                    ref.read(sendMobileOtpNotifierProvider.notifier).otpField =
                        pin;
                  },
                ),
              ),
      ],
    );
  }
}
