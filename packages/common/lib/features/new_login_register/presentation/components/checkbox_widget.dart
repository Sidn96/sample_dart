import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/utils/dialog_content_utils.dart';
import 'package:common/env/env.dart';
import 'package:common/features/new_login_register/presentation/widgets/single_checkbox_widget.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:common/core/presentation/utils/extensions/string_extension.dart';

enum CheckboxTypeEnum {
  termsAndCondition,
  whatsApp,
  age,
  other,
  have_nps_account,
  dnd
}

/// CheckBoxModel
///      - [CheckBoxTextModel] -> List of Simple Text & Text with Dialogs
///      - errorText -> if mandatory and unchecked then show this error message
///
class CheckBoxModel {
  final bool isMandatory;
  final CheckboxTypeEnum type;
  String? errorText;
  bool isChecked;
  List<CheckBoxTextModel> textModels;
  CheckBoxThemeModel? checkBoxThemeModel;

  CheckBoxModel(
      {required this.isMandatory,
      required this.type,
      required this.textModels,
      this.errorText,
      this.isChecked = true,
      this.checkBoxThemeModel});
}

class CheckBoxThemeModel {
  bool? makeHyperLinkTextUnderLined;
  Color? normalTextColor;
  Color? hyperLinkTextColor;

  CheckBoxThemeModel(
      {this.makeHyperLinkTextUnderLined,
      this.hyperLinkTextColor,
      this.normalTextColor});
}

class CheckboxesWidget extends StatelessWidget {
  final List<CheckBoxModel> checkBoxModels;
  final void Function(bool) allMandatoryChecked;
  final void Function(bool)? onWhatsappCommCheckChanged;
  final CheckBoxThemeModel? checkBoxThemeModel;

  const CheckboxesWidget({
    super.key,
    required this.checkBoxModels,
    required this.allMandatoryChecked,
    this.onWhatsappCommCheckChanged,
    this.checkBoxThemeModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.end,
      children: checkBoxModels
          .map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: SingleCheckBoxWidget(
                  checkColor: ColorUtilsV2.hex_35354D,
                  checkBoxThemeModel: checkBoxThemeModel,
                  checkBoxModel: e,
                  onChanged: (val) {
                    e.isChecked = val;
                    if (e.type == CheckboxTypeEnum.whatsApp) {
                      onWhatsappCommCheckChanged?.call(val);
                    }
                    _verifyIfAllMandatoryChecked();
                  },
                ),
              ))
          .toList(),
    );
  }

  void _verifyIfAllMandatoryChecked() {
    var isAllMandatoryChecked = true;
    for (var m in checkBoxModels) {
      if (m.isMandatory) {
        isAllMandatoryChecked &= (m.isChecked);
      }
    }
    allMandatoryChecked(isAllMandatoryChecked);
  }
}

class DefaultCheckBoxModels {
  List<CheckBoxModel> getListOfCheckBoxModels(BuildContext context,
      {bool isAgeCheckNeeded = false}) {
    var resultModels = <CheckBoxModel>[];
    if (isAgeCheckNeeded) {
      resultModels.add(CheckBoxModel(
        isMandatory: true,
        type: CheckboxTypeEnum.age,
        errorText: AppConstants.mandatoryCheckBoxSelection,
        textModels: [
          CheckBoxTextModel(
            text: AppConstants.adult,
          ),
        ],
      ));
    }

    resultModels.add(
      CheckBoxModel(
        isMandatory: true,
        type: CheckboxTypeEnum.termsAndCondition,
        errorText: AppConstants.acceptTAndC,
        textModels: <CheckBoxTextModel>[
          CheckBoxTextModel(text: AppConstants.iAcceptThe),
          CheckBoxTextModel(
            text: AppConstants.termAndCond,
            dialogTitle: AppConstants.termAndCond,
            dialogContent: TermsPrivacyDisclaimerConstant.termsConditions,
          ),
          CheckBoxTextModel(text: ","),
          CheckBoxTextModel(
            text: AppConstants.privacyPolicy,
            dialogTitle: AppConstants.privacyPolicy,
            dialogContent: TermsPrivacyDisclaimerConstant.privacyPolicy,
          ),
          CheckBoxTextModel(text: " & "),
          CheckBoxTextModel(
            text: AppConstants.legalDisclaimer,
            dialogTitle: AppConstants.legalDisclaimer,
            dialogContent: TermsPrivacyDisclaimerConstant.legalDisclaimer,
          ),
          CheckBoxTextModel(text: " & "),
          CheckBoxTextModel(
            text: "DND Disclaimer",
            dialogTitle: "DND Disclaimer",
            dialogContent: "",
          ),
          //CheckBoxTextModel(text: " of Retire 100"),
        ],
      ),
      //
    );
    // DND
    /*  resultModels.add(
      CheckBoxModel(
        isMandatory: true,
        type: CheckboxTypeEnum.dnd,
        errorText: AppConstants.acceptTAndC,
        textModels: <CheckBoxTextModel>[
          CheckBoxTextModel(text: 'I authorise 100 to override the '),
          CheckBoxTextModel(
            text: 'DND',
            dialogTitle: AppConstants.dndDeclaration,
            dialogContent: TermsPrivacyDisclaimerConstant.overrideOfDndDeclaration,
          ),
          CheckBoxTextModel(text: ' registry & contact me for transactional and marketing communications.'),
        ]

      )
    ); */
    resultModels.add(
      CheckBoxModel(
        isMandatory: false,
        type: CheckboxTypeEnum.whatsApp,
        textModels: [
          CheckBoxTextModel(text: AppConstants.agreeToCommunicatedVia),
          CheckBoxTextModel(
            text: AppConstants.whatsApp,
            dialogTitle: AppConstants.whatsApp,
            dialogContent:"",
          ),
        ],
      ),
    );
    return resultModels;
  }

  List<CheckBoxModel> getListOfNPSCustomerDetailsCheckBoxModels(
      BuildContext context,
      {bool isAgeCheckNeeded = false}) {
    var resultModels = <CheckBoxModel>[];
    resultModels.add(
      CheckBoxModel(
          isMandatory: true,
          type: CheckboxTypeEnum.other,
          textModels: [
            CheckBoxTextModel(text: AppConstants.iAcceptThe),
            CheckBoxTextModel(
                text: 'FATCA and Subscriber ',
                dialogTitle: "",// FatcaConstant.fatcaAndSubscriberDeclaration,
                dialogContent: "${Env.baseUrlFromEnv}member/admin/getPolicyDoc?type=fatca",
                isWebUrl: true),
            CheckBoxTextModel(text: 'declaration'),
          ],
          errorText: "Kindly accept the declarations to continue"),
    );
    resultModels.add(
      CheckBoxModel(
          isMandatory: true,
          type: CheckboxTypeEnum.have_nps_account,
          textModels: [
            CheckBoxTextModel(
                text:
                    'I acknowledge that I do not have an existing NPS account.'),
          ],
          errorText: "Kindly accept the declarations to continue"),
    );
    resultModels.add(
      CheckBoxModel(
          isMandatory: true,
          type: CheckboxTypeEnum.other,
          textModels: [
            CheckBoxTextModel(
                text: 'I acknowledge that I am a resident of India and not Politically Exposed Person (PEP)'),
          ],
          errorText: "Kindly accept the declarations to continue"),
    );
    return resultModels;
  }
}

class CheckBoxTextModel {
  ///Simple Text to be shown
  final String text;

  ///If Text is an hyperlink then pass this value
  final String? dialogTitle;

  ///If Text is an hyperlink then pass this value
  final String? dialogContent;
  final bool isWebUrl;

  CheckBoxTextModel({
    required this.text,
    this.dialogTitle,
    this.dialogContent,
    this.isWebUrl = false
  });

  bool get isHyperTextLink => dialogContent.isNotNullNorEmpty();
}
