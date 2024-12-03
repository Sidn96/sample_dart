import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:common/core/presentation/utils/dialog_content_utils.dart';
import 'package:flutter/material.dart';

class BankDeclaration extends StatelessWidget {
  const BankDeclaration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding:
      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText(
                data: AppConstants.bankDeclarationText,
                fontSize: Sizes.textSize16,
                fontWeight: FontWeight.w800,
                textAlign: TextAlign.left,
                fontColor: ColorUtils.black,
                textDecoration: TextDecoration.underline,
              ),
              const SizedBox(height: 10.0),
              const SizedBox(
                height: 300.0,
                child: SingleChildScrollView(
                  child: AppText(
                    data: TermsPrivacyDisclaimerConstant.bankDeclaration,
                    fontSize: Sizes.textSize12,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.left,
                    fontColor: ColorUtils.black,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
