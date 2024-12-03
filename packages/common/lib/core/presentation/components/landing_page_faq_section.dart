import 'package:common/core/presentation/components/member_faq_listing_molecule.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:flutter/material.dart';

class LandingFAQPage extends StatelessWidget {
  const LandingFAQPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorUtils.kSuggestionsBgColor,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 29, bottom: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AppText(
                data: AppConstants.faq,
                textAlign: TextAlign.start,
                fontSize: Sizes.textSize18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Divider(
            height: 1,
            color: ColorUtils.taxdarkGray,
          ),
          PalFaqSection(),
        ],
      ),
    );
  }
}
