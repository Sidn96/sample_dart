import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginComponent extends HookConsumerWidget {
  final TextEditingController phoneController;
  final bool isFieldBottomText;
  final String? numberHeaderName;
  final bool isEnableOtp;
  final bool isOtpfield;
  final ValueNotifier<bool> buttonText;
  final ValueNotifier<bool> startTimer;
  final VoidCallback? onPressed;
  final Function(String value)? onChanged;
  final ValueNotifier<bool> otpOnboardingEntered;
  final ValueNotifier<bool> iAcceptOnboardTc;
  final TextEditingController otpOnboardingController;
  final VoidCallback? resendPressed;
  final ValueNotifier<bool> agreeOnboardWhatsApp;
  final VoidCallback continueOnPressed;
  final ValueNotifier<bool> isLoading;
  final OnCodeEnteredCompletion? onCodeChanged;
  final String? customName;
  final OnCodeEnteredCompletion? onSubmit;
  final ValueNotifier<String?> invalidOtp;
  LoginComponent(
      {required this.phoneController,
      required this.otpOnboardingEntered,
      required this.otpOnboardingController,
      required this.resendPressed,
      required this.startTimer,
      required this.iAcceptOnboardTc,
      required this.agreeOnboardWhatsApp,
      required this.continueOnPressed,
      required this.isLoading,
      required this.invalidOtp,
      this.onCodeChanged,
      this.onSubmit,
      this.customName,
      this.isFieldBottomText = true,
      this.isOtpfield = false,
      required this.buttonText,
      this.onPressed,
      this.isEnableOtp = false,
      this.onChanged,
      this.numberHeaderName,
      super.key});
  final FToast toast = FToast();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resendOnboardOtpTime = useState<int>(31);
    toast.init(context);
    return Stack(children: [
      const Positioned(
          right: 0,
          top: 150,
          child: AppImage(
            imgPath: AssetUtils.eclipseIcon,
            height: 300,
          )),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          PhoneNoTextField(
            contentPadding:
                const EdgeInsets.only(left: 8, top: 8, bottom: 18, right: 8),
            enableBottomSpacing: false,
            numberHeaderName: numberHeaderName,
            phoneNoController: phoneController,
            sufixWidget: TextButton(
              onPressed: (isEnableOtp && !isOtpfield) ? onPressed : null,
              child: AppText(
                  data: AppConstants.sendOTP,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontColor: (isEnableOtp && !isOtpfield)
                      ? ColorUtils.kBlueColor
                      : ColorUtils.disabledColor),
            ),
            onChanged: onChanged,
          ),
          const SizedBox(
            height: 5,
          ),
          Visibility(
            visible: isFieldBottomText,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: AppText(
                  data: customName ?? AppConstants.otpWillBeSent,
                  fontSize: Sizes.textSize12,
                  fontColor: ColorUtils.kYellowColor,
                ),
              ),
            ),
          ),
          if (isOtpfield) ...[
            const SizedBox(
              height: 35,
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  data: AppConstants.enterOtp,
                  fontSize: Sizes.textSize12,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.start,
                  height: 1,
                  fontColor: ColorUtils.kGreyLightColor,
                ),
              ),
            ),
            OtpTextFieldWidget(
                onCodeChanged: onCodeChanged, onSubmit: onSubmit),
            const SizedBox(height: 10),
            OtpTimerWidget(
                startTimer: startTimer,
                invalidOtp: invalidOtp,
                resendOnboardOtpTime: resendOnboardOtpTime,
                resendPressed: resendPressed),
          ],
          const Spacer(),
          TermAndConditionWidget(
              phoneController: phoneController,
              iAcceptOnboardTc: iAcceptOnboardTc),
          WhatsAppTermsWidget(agreeOnboardWhatsApp: agreeOnboardWhatsApp),
          OtpButtonWidget(
              iAcceptOnboardTc: iAcceptOnboardTc,
              isLoading: isLoading,
              otpOnboardingEntered: otpOnboardingEntered,
              continueOnPressed: continueOnPressed)
        ],
      )
    ]);
  }
}
