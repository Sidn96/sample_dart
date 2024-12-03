import 'package:common/core/domain/checkbox_value_enum.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/font_styles.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:common/core/presentation/utils/dialog_content_utils.dart';
import 'package:common/core/presentation/utils/style_manager.dart';
import 'package:common/core/presentation/widgets/bank_declaration.dart';
import 'package:common/core/presentation/widgets/common_tnc_pp_whats.dart';
import 'package:common/core/presentation/widgets/pmla.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AppCheckBox extends StatelessWidget {
  final Function(bool value) onChange;
  final bool isNormalText;
  final String? normalText;
  final CheckboxValue? checkBoxValue;
  final bool changedValue;
  final String? errorMessage;

  // if 'isNormalText' is true then should pass 'normalText'
  // if 'isNormalText' is false then should pass 'CheckboxValue' enum
  const AppCheckBox({
    Key? key,
    required this.onChange,
    required this.isNormalText,
    this.errorMessage = "",
    this.normalText,
    this.checkBoxValue = CheckboxValue.termsAndCondition,
    required this.changedValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: ColorUtils.kGreenLightColor,
                    value: changedValue,
                    onChanged: (value) {
                      onChange(value!);
                    },
                    side: MaterialStateBorderSide.resolveWith(
                      (states) => BorderSide(
                          width: 1,
                          color: errorMessage?.isNotEmpty ?? false
                              ? ColorUtils.errorColor
                              : ColorUtils.kGreyBorderColor),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            !isNormalText
                ? Expanded(child: linkableText(context))
                : Flexible(
                    child: AppText(
                      data: normalText ?? '',
                      fontSize: Sizes.textSize10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
          ],
        ),
        Visibility(
          visible: errorMessage!.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
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
    );
  }

  Widget linkableText(BuildContext context) {
    if (checkBoxValue == CheckboxValue.termsAndCondition) {
      return tAndCSpan(context);
    } else if (checkBoxValue == CheckboxValue.whatsApp) {
      return whatsAppSpan(context);
    } else if (checkBoxValue == CheckboxValue.dndRegistered) {
      return dndSpan(context);
    } else {
      return paymentTermsSpan(context);
    }
  }

  Widget tAndCSpan(BuildContext context) {
    return RichText(
        text: TextSpan(
            style: StyleManager.interStyle(
                height: 1.3,
                textColor: ColorUtils.black,
                fontSize: Sizes.textSize10,
                fontWeight: FontWeight.w400),
            children: [
          const TextSpan(
            text: AppConstants.iAcceptThe,
          ),
          TextSpan(
            text: AppConstants.termAndCond,
            style: FontStyles.interStyle(
              textColor: ColorUtils.kBlueColor,
              fontSize: Sizes.textSize10,
              fontWeight: FontWeight.w400,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                showDialog(
                    useRootNavigator: false,
                    context: context,
                    builder: (context) =>
                        const CommonTermsAndConditionsDialog());
              },
          ),
          const TextSpan(
            text: ", ",
          ),
          TextSpan(
            text: AppConstants.privacyPolicy,
            style: FontStyles.interStyle(
              textColor: ColorUtils.kBlueColor,
              fontSize: Sizes.textSize10,
              fontWeight: FontWeight.w400,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                showDialog(
                    useRootNavigator: false,
                    context: context,
                    builder: (context) => const CommonTermsAndConditionsDialog(
                          termAndConditionsContentHeader:
                              AppConstants.privacyText,
                          termAndConditionsContent:
                              TermsPrivacyDisclaimerConstant.privacyPolicy,
                        ));
              },
          ),
          const TextSpan(
            text: " & ",
          ),
          TextSpan(
            text: AppConstants.legalDisclaimer,
            style: FontStyles.interStyle(
              textColor: ColorUtils.kBlueColor,
              fontSize: Sizes.textSize10,
              fontWeight: FontWeight.w400,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                showDialog(
                    useRootNavigator: false,
                    context: context,
                    builder: (context) => const CommonTermsAndConditionsDialog(
                          termAndConditionsContentHeader:
                              AppConstants.legalDisclaimer,
                          termAndConditionsContent:
                              TermsPrivacyDisclaimerConstant.legalDisclaimer,
                        ));
              },
          ),
          const TextSpan(
            text: " of 100",
          ),
        ]));
  }

  Widget whatsAppSpan(BuildContext context) {
    return RichText(
        text: TextSpan(
            style: StyleManager.interStyle(
                height: 1.3,
                textColor: ColorUtils.black,
                fontSize: Sizes.textSize10,
                fontWeight: FontWeight.w400),
            children: [
          const TextSpan(
            text: AppConstants.iAgreeCommunicate,
          ),
          const TextSpan(
            text: " ",
          ),
          TextSpan(
            text: AppConstants.whatsAppText,
            style: FontStyles.interStyle(
              textColor: ColorUtils.kBlueColor,
              fontSize: Sizes.textSize10,
              fontWeight: FontWeight.w400,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                showDialog(
                    useRootNavigator: false,
                    context: context,
                    builder: (context) => const CommonTermsAndConditionsDialog(
                          termAndConditionsContentHeader:
                              AppConstants.whatsAppText,
                          termAndConditionsContent:
                              TermsPrivacyDisclaimerConstant
                                  .whatsappDeclaration,
                        ));
              },
          ),
        ]));
  }

  Widget paymentTermsSpan(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: Wrap(
        children: [
          const AppText(
            data: AppConstants.paymentTAndCLabel,
            height: 1.3,
            fontSize: Sizes.textSize10,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.start,
            fontColor: ColorUtils.black,
          ),
          InkWell(
            onTap: () {
              showDialog(
                useRootNavigator: false,
                context: context,
                builder: (context) => const PMLADialog(),
              );
            },
            child: const AppText(
              data: AppConstants.pmlaActLabel,
              height: 1.3,
              fontSize: Sizes.textSize10,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.start,
              fontColor: ColorUtils.kBlueColor,
            ),
          ),
          const AppText(
            data: ' and ',
            height: 1.3,
            fontSize: Sizes.textSize10,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.start,
            fontColor: ColorUtils.black,
          ),
          InkWell(
            onTap: () {
              showDialog(
                useRootNavigator: false,
                context: context,
                builder: (context) => const BankDeclaration(),
              );
            },
            child: const AppText(
              data: AppConstants.subscriberBankLabel,
              height: 1.3,
              fontSize: Sizes.textSize10,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.start,
              fontColor: ColorUtils.kBlueColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget dndSpan(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: StyleManager.interStyle(
            height: 1.3,
            textColor: ColorUtils.black,
            fontSize: Sizes.textSize10,
            fontWeight: FontWeight.w400),
        children: [
          const TextSpan(
            text: AppConstants.iAuthoriseThe,
          ),
          TextSpan(
            text: " DND ",
            style: FontStyles.interStyle(
              textColor: ColorUtils.kBlueColor,
              fontSize: Sizes.textSize10,
              fontWeight: FontWeight.w400,
            ),
            //
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          const TextSpan(
            text:
                "registry & contact me\nfor transactional and marketing communications.",
          ),
        ],
      ),
    );
  }
}
