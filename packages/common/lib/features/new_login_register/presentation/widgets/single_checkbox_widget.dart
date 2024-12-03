import 'package:common/core/presentation/components_v2/app_snackbar.dart';
import 'package:common/core/presentation/components_v2/components_v2.dart';
import 'package:common/core/presentation/routing/route_strings.dart';
import 'package:common/core/presentation/widgets/common_tnc_dialog_v2.dart';
import 'package:common/env/env.dart';
import 'package:common/features/new_login_register/presentation/components/checkbox_widget.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:common/core/presentation/utils/extensions/string_extension.dart';
import 'package:go_router/go_router.dart';

class SingleCheckBoxWidget extends HookWidget {
  final CheckBoxModel checkBoxModel;
  final void Function(bool) onChanged;
  final Color activeColor;
  final Color errorColor;
  final Color? checkColor;
  final CheckBoxThemeModel? checkBoxThemeModel;

const SingleCheckBoxWidget({
    super.key,
    required this.checkBoxModel,
    required this.onChanged,
    this.checkColor,
    this.activeColor = ColorUtilsV2.specialSuccess300,
    this.checkBoxThemeModel,
    this.errorColor = ColorUtilsV2.specialDestructive400,
  });

  @override
  Widget build(BuildContext context) {
    var isChecked = useState(checkBoxModel.isChecked);

    if (!isChecked.value && checkBoxModel.errorText.isNotNullNorEmpty()) {
      Future.delayed(const Duration(milliseconds: 200), () {
        AppSnackBar.show(context: context, message: checkBoxModel.errorText!);
      });
    } else if (isChecked.value && checkBoxModel.isMandatory) {
      Future.delayed(const Duration(milliseconds: 200), () {
        if (context.mounted) {
          AppSnackBar.hide(context);
        }
      });
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Theme(
          data: ThemeData(unselectedWidgetColor: ColorUtils.lightGray),
          child: SizedBox(
            width: 20,
            height: 20,
            child: Checkbox(
              value: isChecked.value,
              checkColor: checkColor,
              onChanged: (val) {
                onChanged.call(val ?? false);
                isChecked.value = val ?? false;
              },
              activeColor: activeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              side: MaterialStateBorderSide.resolveWith(
                (states) => BorderSide(
                    width: 1,
                    color: _borderColor(
                        isChecked.value, checkBoxModel.isMandatory)),
              ),
            ),
          ),
        ),
        const SizedBox(width: 6.0),
        Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 4),
                child: buildRichTextWidget(context, checkBoxModel.textModels,
                    isChecked.value, checkBoxModel.isMandatory),
          ),
        ),
      ],
    );
  }

  Color _borderColor(bool isChecked, bool isMandatory) {
    var defaultColor = ColorUtils.greyLight;
    if (isChecked) {
      return activeColor;
    } else if (isMandatory) {
      return errorColor;
    }
    return defaultColor;
  }

  RichText buildRichTextWidget(BuildContext context,
      List<CheckBoxTextModel> models, bool isChecked, bool isMandatory) {
    var color = ColorUtilsV2.hex_717182;
    if (!isChecked && isMandatory) {
      color = ColorUtilsV2.hex_F87171;
    }

    return RichText(
      text: TextSpan(children: [
        for (var m in models)
          TextSpan(
              text: m.text,
              style: styleText(
                  m.isHyperTextLink
                      ? checkBoxThemeModel?.hyperLinkTextColor ??
                          ColorUtilsV2.hex_4E52F8
                      : checkBoxThemeModel?.normalTextColor ?? color,
                  (checkBoxThemeModel?.makeHyperLinkTextUnderLined ?? false)
                      ? TextDecoration.underline
                      : TextDecoration.none,
                  m.isHyperTextLink ? FontWeight.w600 : FontWeight.w500),
              recognizer: m.isHyperTextLink
                  ? (TapGestureRecognizer()
                    ..onTap = () {
                      print("title = ${m.dialogTitle}");
                      if (m.isWebUrl) {
                        context.pushNamed(CommonRouteString.commonHtmlView,
                            extra: {
                              "title": m.dialogTitle,
                              "htmlContentUrl": m.dialogContent
                            });
                      } else if (m.dialogTitle == "Terms & Conditions") {
                        context.pushNamed(CommonRouteString.termsAndConditions);
                      } else if (m.dialogTitle == " Privacy Policy") {
                        context.pushNamed(CommonRouteString.privacyPolicy);
                      } else if (m.dialogTitle == "Legal Disclaimer") {
                        context.pushNamed(CommonRouteString.legalDisclaimer);
                      } else if (m.text.trim()=="FATCA"){
                        context.pushNamed(CommonRouteString.commonHtmlView,extra: {
                          "title":"FATCA",
                          "htmlContentUrl":"${Env.baseUrlFromEnv}member/admin/getPolicyDoc?type=fatca"

                        });
                      } else if (m.dialogContent?.startsWith("http") ?? false) {
                        context.pushNamed(CommonRouteString.commonHtmlView,
                            extra: {
                              "title": m.text,
                              "htmlContentUrl": m.dialogContent
                            });
                      }
                      else {
                        showDialog(
                            useRootNavigator: false,
                            context: context,
                            builder: (context) {
                              return CommonTermsAndConditionsDialogV2(
                                termAndConditionsContentHeader: m.dialogTitle,
                                termAndConditionsContent: m.dialogContent,
                              );
                            });
                      }
                    })
                  : null)
      ]),
    );
  }

  TextStyle styleText(
      Color color, TextDecoration decoration, FontWeight fontWeight) {
    return TextStyles.manropeStyle(12.0,
        color: color,
        height: 16.0/12.0,
        decoration: decoration,
        fontWeight: fontWeight);
  }
}

