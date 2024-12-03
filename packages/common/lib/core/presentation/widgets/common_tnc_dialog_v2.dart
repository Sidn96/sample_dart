import 'package:common/core/presentation/components_v2/components_v2.dart';
import 'package:common/core/presentation/utils/dialog_content_utils.dart';
import 'package:common/core/presentation/widgets/custom_raw_scrollbar.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

class CommonTermsAndConditionsDialogV2 extends HookWidget {
  final String? termAndConditionsContent;
  final String? termAndConditionsContentHeader;
  const CommonTermsAndConditionsDialogV2(
      {Key? key,
      this.termAndConditionsContent,
      this.termAndConditionsContentHeader})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contents = useState('');
    final loading = useState(true);

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 200), () {
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
        margin: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextV2(
              data: termAndConditionsContentHeader ??
                  AppConstants.truePalTermsConditionsText,
              textAlign: TextAlign.center,
              fontColor: ColorUtils.blackColor,
              fontWeight: FontWeight.w800,
              fontSize: Sizes.textSize18,
              textDecoration: TextDecoration.underline,
            ),
            const SizedBox(height: 28.0),
            SizedBox(
              height: 350.0,
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
                          style: TextStyles.manropeStyle(
                              Sizes.textSize12,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 20.0),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 100,
                height: 38,
                child: SecondaryAppButtonV2(
                 label: AppConstants.close,
                  onTap: ()=> Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
