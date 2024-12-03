import 'package:common/core/presentation/styles/font_styles.dart';
import 'package:common/core/presentation/utils/dialog_content_utils.dart';
import 'package:common/core/presentation/widgets/custom_raw_scrollbar.dart';
import 'package:common/core/presentation/widgets/member_app_button.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

class CommonTermsAndConditionsDialog extends HookWidget {
  const CommonTermsAndConditionsDialog({Key? key,
    this.termAndConditionsContent,
    this.termAndConditionsContentHeader})
      : super(key: key);
  final String? termAndConditionsContent;
  final String? termAndConditionsContentHeader;

  @override
  Widget build(BuildContext context) {
    final contents = useState('');
    final loading = useState(true);

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 1000), () {
        contents.value = termAndConditionsContent ??
            TermsPrivacyDisclaimerConstant.termsConditions;
        loading.value = false;
      });
      return null;
    }, []);

    final controller = ScrollController();
    return Dialog(
      backgroundColor: ColorUtils.white,
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      surfaceTintColor: ColorUtils.white,
      child: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              data: termAndConditionsContentHeader ??
                  AppConstants.truePalTermsConditionsText,
              textAlign: TextAlign.left,
              fontColor: ColorUtils.blackColor,
              fontWeight: FontWeight.w800,
              fontSize: Sizes.textSize18,
              textDecoration: TextDecoration.underline,
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              height: 300.0,
              child: loading.value
                  ? const Center(child: CircularProgressIndicator())
                  : CustomRawScrollbar(
                      controller: controller,
                      thickness: 5,
                      trackVisibility: true,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        controller: controller,
                        scrollDirection: Axis.vertical,
                        physics: const ClampingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          contents.value,
                          textAlign: TextAlign.left,
                          style: FontStyles.interStyle(
                              textColor: Colors.black,
                              fontSize: Sizes.textSize12,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MemberAngelAppButton(
                  buttonWidth: 100,
                  buttonHeight: 40,
                  label: AppConstants.close,
                  onSuccessHandler: () => Navigator.pop(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
