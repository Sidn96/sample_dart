import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/common_tnc_pp_whats.dart';
import '../providers/notifiers/new_login_notifiers.dart';

class TermConditionCta extends HookConsumerWidget {
  final Color? checkBoxColor;
  final Color? checkBoxBorderColor;
  final bool? isAdultPalCheckbox;
  final ValueNotifier<bool>? isAdult;
  final ValueNotifier<bool> iAcceptTC;
  final ValueNotifier<bool> isWhatApp;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? otpController;
  final String? errorMessage;
  final String? adultErrorMessage;
  final String? whatsAppErrorMessage;
  final String? termAndConditionsContent;
  final String? privacyPolicyContent;
  final String? legalDisclaimerContent;
  final String? termAndConditionsContentHeader;
  final String? privacyPolicyContentHeader;
  final String? legalDisclaimerContentHeader;
  const TermConditionCta(
      {super.key,
      required this.iAcceptTC,
      required this.isWhatApp,
      this.isAdult,
      this.contentPadding,
      this.isAdultPalCheckbox,
      this.checkBoxBorderColor,
      this.checkBoxColor,
      this.otpController,
      this.errorMessage,
      this.adultErrorMessage,
      this.whatsAppErrorMessage,
      this.termAndConditionsContent,
      this.legalDisclaimerContent,
      this.privacyPolicyContent,
      this.termAndConditionsContentHeader,
      this.legalDisclaimerContentHeader,
      this.privacyPolicyContentHeader});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: contentPadding ?? const EdgeInsets.only(bottom: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isAdultPalCheckbox == true)
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        customcheckBox(
                          side: WidgetStateBorderSide.resolveWith(
                            (states) => BorderSide(
                                width: 1,
                                color: adultErrorMessage?.isNotEmpty ?? false
                                    ? ColorUtils.errorColor
                                    : checkBoxBorderColor ??
                                        ColorUtils.greyColor),
                          ),
                          value: isAdult?.value,
                          onChanged: (value) {
                            isAdult?.value = value!;
                            if (isAdult!.value &&
                                ref.watch(loginShowSendOtpProvider) == true &&
                                otpController!.text.isNotEmpty) {
                              ref
                                  .read(loginEnableCtaButtonProvider.notifier)
                                  .changeActiveState(true);
                            } else {}
                          },
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, top: 2),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: AppConstants.adult,
                                    style: styleText(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: adultErrorMessage!.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 36, bottom: 4),
                        child: AppText(
                          data: adultErrorMessage ?? "",
                          fontSize: Sizes.defaultTextSize,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.start,
                          fontColor: ColorUtils.errorColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      customcheckBox(
                        side: WidgetStateBorderSide.resolveWith(
                          (states) => BorderSide(
                              width: 1,
                              color: errorMessage?.isNotEmpty ?? false
                                  ? ColorUtils.errorColor
                                  : checkBoxBorderColor ??
                                      ColorUtils.greyColor),
                        ),
                        value: iAcceptTC.value,
                        onChanged: (value) {
                          iAcceptTC.value = value!;
                          if (iAcceptTC.value &&
                              ref.watch(loginShowSendOtpProvider) == true &&
                              otpController!.text.isNotEmpty) {
                            ref
                                .read(loginEnableCtaButtonProvider.notifier)
                                .changeActiveState(true);
                          } else {}
                        },
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12, top: 2),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: AppConstants.iAcceptThe,
                                  style: styleText(),
                                ),
                                TextSpan(
                                  text: AppConstants.termAndCond,
                                  style: styleText(
                                    fcolor: ColorUtils.kBlueColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Single tapped.
                                      showDialog(
                                          useRootNavigator: false,
                                          context: context,
                                          builder: (context) =>
                                              CommonTermsAndConditionsDialog(
                                                termAndConditionsContent:
                                                    termAndConditionsContent,
                                                termAndConditionsContentHeader:
                                                    termAndConditionsContentHeader,
                                              ));
                                    },
                                ),
                                TextSpan(
                                  text: " &",
                                  style: styleText(),
                                ),
                                TextSpan(
                                  text: AppConstants.privacyPolicy,
                                  style: styleText(
                                    fcolor: ColorUtils.kBlueColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      showDialog(
                                          useRootNavigator: false,
                                          context: context,
                                          builder: (context) =>
                                              CommonTermsAndConditionsDialog(
                                                termAndConditionsContent:
                                                    privacyPolicyContent,
                                                termAndConditionsContentHeader:
                                                    privacyPolicyContentHeader,
                                              ));
                                      // Single tapped.
                                    },
                                ),
                                /*  TextSpan(
                                  text: " & ",
                                  style: styleText(),
                                ),
                                TextSpan(
                                  text: AppConstants.legalDisclaimer,
                                  style: styleText(
                                    fcolor: ColorUtils.kBlueColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              CommonTermsAndConditionsDialog(
                                                termAndConditionsContent:
                                                    legalDisclaimerContent,
                                                termAndConditionsContentHeader:
                                                    legalDisclaimerContentHeader,
                                              ));
                                      // Single tapped.
                                    },
                                ),*/
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: errorMessage!.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 36, bottom: 4),
                      child: AppText(
                        data: errorMessage ?? "",
                        fontSize: Sizes.defaultTextSize,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.start,
                        fontColor: ColorUtils.errorColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      customcheckBox(
                        side: WidgetStateBorderSide.resolveWith(
                          (states) => BorderSide(
                              width: 1,
                              color: whatsAppErrorMessage?.isNotEmpty ?? false
                                  ? ColorUtils.errorColor
                                  : checkBoxBorderColor ??
                                      ColorUtils.greyColor),
                        ),
                        value: isWhatApp.value,
                        onChanged: (value) {
                          isWhatApp.value = value!;
                          if (isWhatApp.value &&
                              ref.watch(loginShowSendOtpProvider) == true &&
                              otpController!.text.isNotEmpty) {
                            ref
                                .read(loginEnableCtaButtonProvider.notifier)
                                .changeActiveState(true);
                          } else {}
                        },
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: AppConstants
                                      .truePalAgreeToCommunicatedVia,
                                  style: styleText(),
                                ),
                                /* TextSpan(
                          text: AppConstants.whatsApp,
                          style: styleText(
                            fcolor: ColorUtils.kBlueColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showDialog(
                                  context: context,
                                  builder: (context) =>
                                      const CommonTermsAndConditionsDialog());
                              // Single tapped.
                            },
                        ),*/
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: whatsAppErrorMessage!.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 36, bottom: 4),
                      child: AppText(
                        data: whatsAppErrorMessage ?? "",
                        fontSize: Sizes.defaultTextSize,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.start,
                        fontColor: ColorUtils.errorColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget customcheckBox(
      {required void Function(bool?)? onChanged,
      required bool? value,
      BorderSide? side}) {
    return Theme(
      data: ThemeData(
          unselectedWidgetColor: checkBoxBorderColor ?? ColorUtils.greyColor),
      child: SizedBox(
        width: 24,
        height: 28,
        child: Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: checkBoxColor ?? ColorUtils.kGreenLightColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
          side: side,
        ),
      ),
    );
  }

  TextStyle styleText({Color? fcolor}) {
    return TextStyle(
      fontSize: Sizes.textSize10,
      fontWeight: FontWeight.w400,
      color: fcolor ?? ColorUtils.black,
    );
  }
}
