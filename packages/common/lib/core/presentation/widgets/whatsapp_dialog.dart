import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/font_styles.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:common/core/presentation/utils/dialog_content_utils.dart';
import 'package:flutter/material.dart';

class WhatsAppDialog extends StatelessWidget {
  const WhatsAppDialog({Key? key}) : super(key: key);

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
                data: AppConstants.whatsAppText,
                textAlign: TextAlign.left,
                textDecoration: TextDecoration.underline,
                fontWeight: FontWeight.w800,
                fontColor: ColorUtils.blackColor,
                fontSize: Sizes.textSize16,
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                height: 300.0,
                child: SingleChildScrollView(
                  child: Text(
                    TermsPrivacyDisclaimerConstant.whatsappDeclaration,
                    textAlign: TextAlign.left,
                    style: FontStyles.interStyle(
                        textColor: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
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
