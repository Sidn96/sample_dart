import 'package:common/core/presentation/extensions/widget_extension.dart';
import 'package:common/core/presentation/providers/notifiers/login_notifiers.dart';
import 'package:common/core/presentation/providers/notifiers/otp_notifier.dart';
import 'package:common/core/presentation/providers/notifiers/phone_num_validator_notifier.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:common/core/presentation/styles/color_utils.dart';

import 'package:common/core/presentation/utils/app_string_constants.dart';

class LoginButtonMolecule extends HookConsumerWidget {
  LoginButtonMolecule({
    Key? key,
    required this.apiSources,
    required this.path,
    this.onSubmitPressed,
    this.fullNameWidget = true,
  }) : super(key: key);

  int? isFullNameEmpty;
  bool? isWhatsAppChecked;
  bool? isTermsAndCondChecked;
  bool? isRememberMeChecked;
  int? isPhoneValid;
  int? otpValidationValue;
  bool? isOTPFieldShown;
  final String apiSources;
  final String path;
  final VoidCallback? onSubmitPressed;
  final bool fullNameWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    isPhoneValid = ref.watch(phoneNoValidationNotifierProvider);
    isFullNameEmpty = ref.watch(fullNameValidateNotifierProvider);
    isWhatsAppChecked = ref.watch(checkWhatsAppNotifierProvider);
    isTermsAndCondChecked = ref.watch(checkTermsAndConditionNotifierProvider);
    isRememberMeChecked = ref.watch(checkRememberMeNotifierProvider);

    isOTPFieldShown = ref.watch(toShowOTPFieldProvider);
    otpValidationValue = ref.watch(oTPValidationNotifierProvider);

    final loginSuccess = ref.watch(loginFCSuccessProvider);

    return Center(
      child: Container(
          // margin: EdgeInsets.only(bottom: 24.0),
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          width: MediaQuery.of(context).size.width,
          height: 46,
          child: ElevatedButton(
            onPressed: () {
              onSubmitPressed?.call();
            },
            style: filledButtonStyle(
                radius: 4, backgroundColor: doAllFieldsAreValid() ? ColorUtils.kBlueColor : ColorUtils.disabledColor),
            child: AppText(
                data: ref.watch(unauthorizedNotifierProvider) == null ? isOTPFieldShown! ? AppConstants.submit :  AppConstants.sendOTP: AppConstants.registerAsAngel,
                textAlign: TextAlign.center,
                fontSize: Sizes.textSize14,
                fontWeight: FontWeight.w400,
                fontColor: doAllFieldsAreValid() ? ColorUtils.white : ColorUtils.kTabSwitchColor),
          )),
    );
  }

  bool doAllFieldsAreValid() {

    print(
        "$isPhoneValid | $fullNameWidget | $isFullNameEmpty | $isWhatsAppChecked | $isTermsAndCondChecked | $isOTPFieldShown | $otpValidationValue");
    if (isPhoneValid == 0 && isWhatsAppChecked! && isTermsAndCondChecked!) {
      if (fullNameWidget && isFullNameEmpty == 0) {
        return true;
      }
      if (isOTPFieldShown!) {
        if (otpValidationValue != 0) {
          return false;
        } else {
          return true;
        }
      }
      return true;
    } else {
      return false;
    }
  }
}
