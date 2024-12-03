import 'package:common/core/presentation/components/app_button.dart';
import 'package:common/features/login_signup/presentation/providers/active_form_provider.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LoginSignupCtaButton extends ConsumerWidget {
  final VoidCallback onGetOtpPressed;

  final VoidCallback onSubmitSuccessHandler;
  final ValueNotifier<bool> iAcceptTC;
  final TextEditingController fullNameController;
  final TextEditingController dobController;
  const LoginSignupCtaButton(
      {super.key,
      required this.onGetOtpPressed,
      required this.onSubmitSuccessHandler,
      required this.iAcceptTC,
      required this.dobController,
      required this.fullNameController});

  @override
  Widget build(BuildContext context, ref) {
    final enableCta = ref.watch(enableCtaButtonProvider);
    final buttonText = ref.watch(enableCtaButtonTextProvider);
    return AppButton(
      label: buttonText,
      buttonBgColor: iAcceptTC.value && enableCta
          ? ColorUtils.kBlueColor
          : ColorUtils.kBlueLightColor,
      buttonWidth: Sizes.screenWidth() * 0.9,
      onPressed: () async {
        if (iAcceptTC.value && enableCta && buttonText == AppConstants.next) {
          context.loaderOverlay.show();
          await Future.delayed(const Duration(seconds: 1));
          context.loaderOverlay.hide();
          ref.read(activeFormProviderProvider.notifier).changeActiveIndex(1);
          ref.read(enableCtaButtonProvider.notifier).changeActiveState(false);
        }
        if (iAcceptTC.value &&
            enableCta &&
            buttonText == AppConstants.sendOTP) {
          // send otp call
          ///use this comment provider when you want to show otpfield
          //  ref.read(showSendOtpProvider.notifier).changeActiveState(true);
          ref
              .read(enableCtaButtonTextProvider.notifier)
              .changeActiveState(AppConstants.submit);
          ref.read(enableCtaButtonProvider.notifier).changeActiveState(false);
          onGetOtpPressed();
        }

        if (iAcceptTC.value && enableCta && buttonText == AppConstants.submit) {
          // on submit call
          onSubmitSuccessHandler();
        }
      },
    );
  }
}
