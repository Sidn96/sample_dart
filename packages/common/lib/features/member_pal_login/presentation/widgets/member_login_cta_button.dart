import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/global_loading_indicator.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/core/presentation/widgets/member_app_button.dart';
import 'package:common/core/presentation/widgets/toast_custom_widget.dart';
import 'package:common/features/member_pal_login/domain/entities/member_signup_login_entity.dart';
import 'package:common/features/member_pal_login/presentation/providers/member_signup_login_provider.dart';
import 'package:flutter/material.dart';

class MemberLoginCtaButton extends ConsumerWidget {
  final Function()? onSendOtpPressed;
  final Function(String)? onSubmit;
  const MemberLoginCtaButton({
    super.key,
    required this.onSubmit,
    this.onSendOtpPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(memberSignUpLoginProvierProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: MemberAngelAppButton(
        label: label(loginForm),
        bttnEnabled: enableButton(loginForm),
        buttonWidth: double.infinity,
        onSuccessHandler: () async {
          FocusScope.of(context).unfocus();
          if (label(loginForm) == AppConstants.sendOtp) {
            onSendOtpPressed?.call();
            await sendOtpCall(ref, context);
          } else if (label(loginForm) == AppConstants.submit) {
            onSubmit?.call(loginForm.otp ?? "");
          }
        },
      ),
    );
  }

  bool enableButton(MemberSignupLoginEntity loginForm) {
    if (loginForm.isSendOTPPressed == true &&
        loginForm.isMobileEntered() &&
        loginForm.isOtpEntered() &&
        loginForm.isMemberSignUpLoginFormValid()) {
      // checking submit is not pressed but mobile and otp entered
      return true;
    } else if (loginForm.isSendOTPPressed == false &&
        loginForm.isMobileEntered() &&
        loginForm.isCtaChecked() &&
        loginForm.isOtpEntered() == false) {
      // checking otp field is false and mobile is enter properly
      return true;
    } else if (loginForm.isSendOTPPressed == true &&
        loginForm.isOtpEntered() &&
        loginForm.isMobileEntered() &&
        loginForm.isMemberSignUpLoginFormValid()) {
      // check if mobile is enter properly and otp enter properly
      return true;
    } else {
      return false;
    }
  }

  String label(MemberSignupLoginEntity loginForm) {
    if (loginForm.isSendOTPPressed == true &&
        loginForm.isMobileEntered() &&
        loginForm.isOtpEntered()) {
      // check if mobile is enter properly and otp enter properly
      return AppConstants.submit;
    } else if (loginForm.isSendOTPPressed == true &&
        loginForm.isMobileEntered() &&
        loginForm.isOtpEntered() == false) {
      // check if mobile is enter properly and otp enter properly
      return AppConstants.submit;
    } else if (loginForm.isSendOTPPressed == false &&
        loginForm.isMobileEntered() &&
        loginForm.isOtpEntered() == false) {
      // checking otp field is false and mobile is enter properly
      return AppConstants.sendOtp;
    } else {
      return "Next";
    }
  }

  Future<void> sendOtpCall(WidgetRef ref, BuildContext context) async {
    ref.read(memberSignUpLoginProvierProvider.notifier).setOtpSendPressed(true);
    showProgressBar(ref);
    final result = await ref.read(memberPalSendOtpProvider.future);
    hideProgressBar(ref);
    if (result == false) {
      // failed to send otp try again
      showToastBox(context,
          message: AppConstants.failedTosendOtp,
          toastDuration: const Duration(seconds: 2));
    }
  }
}
