import 'package:common/core/presentation/components/new_phoneNo_textfield.dart';
import 'package:common/features/login_signup/presentation/providers/active_form_provider.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

class MobileNumberField extends HookConsumerWidget {
  final TextEditingController emailTextEditingController;
  final TextEditingController mobileNumberController;
  final bool? showCountryPicker;
  final bool isEmailId;
  final TextEditingController? otpController;
  const MobileNumberField(
      {super.key,
      required this.mobileNumberController,
      this.showCountryPicker,
      required this.emailTextEditingController,
      this.otpController,
      required this.isEmailId});

  @override
  Widget build(BuildContext context, ref) {
    final mobileNumChecker = ref.watch(mobileNumberCheckerProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NewPhoneNoTextField(
          headerValue: "Mobile No.",
          enableBottomSpacing: false,
          phoneNoController: mobileNumberController,
          contentPadding: const EdgeInsets.only(right: 2, bottom: 8),
          onChanged: (value) {
            if (otpController?.text.isNotEmpty ?? false) {
              otpController!.clear();
            }
            if (value.length == 10) {
              final result = ref
                  .read(mobileNumberCheckerProvider.notifier)
                  .mobileRegex(mobileNumberController.text);

              if (isEmailId) {
                if (result &&
                    emailTextEditingController.text.isNotEmpty &&
                    ref.read(emailValidationNotifierProvider) == "") {
                  ref
                      .read(enableCtaButtonProvider.notifier)
                      .changeActiveState(true);
                  ref
                      .read(enableCtaButtonTextProvider.notifier)
                      .changeActiveState(AppConstants.sendOTP);
                }
              } else {
                if (result) {
                  ref
                      .read(enableCtaButtonProvider.notifier)
                      .changeActiveState(true);
                  ref
                      .read(enableCtaButtonTextProvider.notifier)
                      .changeActiveState(AppConstants.sendOTP);
                }
              }
            } else {
              ref
                  .read(mobileNumberCheckerProvider.notifier)
                  .mobileRegex(mobileNumberController.text);

              ref
                  .read(enableCtaButtonProvider.notifier)
                  .changeActiveState(false);
              ref
                  .read(enableCtaButtonTextProvider.notifier)
                  .changeActiveState(AppConstants.next);
            }
          },
        ),
        if (mobileNumChecker != "") ...[
          const SizedBox(height: 10),
          AppText(
              data: mobileNumChecker,
              fontSize: 12,
              fontColor: mobileNumChecker == AppConstants.getOtpOnNumMessage
                  ? ColorUtils.kYellowColor
                  : ColorUtils.errorColor)
        ],
      ],
    );
  }
}
