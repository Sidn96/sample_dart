import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:flutter/material.dart';

///Quiz title
class TitleWidget extends StatelessWidget {
  final String titleNumber;
  final String titleName;

  const TitleWidget(
      {super.key, required this.titleNumber, required this.titleName});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 28, top: 36),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextV2(
              data: titleNumber,
              fontSize: Sizes.textSize20,
              fontColor: ColorUtilsV2.hex_35354D,
              fontWeight: FontWeight.w200,
            ),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: AppTextV2(
                data: titleName,
                fontSize: Sizes.textSize18,
                fontColor: ColorUtilsV2.hex_35354D,
                fontWeight: FontWeight.w300,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ));
  }
}
