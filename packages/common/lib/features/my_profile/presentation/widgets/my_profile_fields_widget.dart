import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:flutter/material.dart';

class MyProfileFieldsWidget extends StatelessWidget {
  const MyProfileFieldsWidget(
      {super.key, required this.headerText, required this.valueText});

  final String headerText;
  final String? valueText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: AppText(
            data: headerText,
            fontSize: Sizes.textSize12,
            fontColor: ColorUtils.greyLight,
            fontWeight: FontWeight.w400,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: AppText(
            data: valueText ?? '-',
            fontSize: Sizes.textSize16,
            fontColor: ColorUtils.kBlackLightColor,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}
