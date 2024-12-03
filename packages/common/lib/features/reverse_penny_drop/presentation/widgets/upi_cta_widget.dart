import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

class UpiCtaWidget extends StatelessWidget {
  final Function()? onTap;
  final String iconPath;
  final String label;
  final String? subTitle;
  const UpiCtaWidget({
    super.key,
    this.onTap,
    required this.iconPath,
    required this.label,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorUtilsV2.hex_E5E7EB),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            AppImage(
              imgPath: iconPath,
              height: 40,
              width: 40,
              boxFit: BoxFit.contain,
              isSvg: false,
              package: "common",
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextV2(
                  data: label,
                  fontSize: 14,
                  height: 1.8,
                  fontWeight: FontWeight.w500,
                ),
                if (subTitle != null)
                  AppTextV2(
                    data: subTitle!,
                    fontSize: 12,
                    height: 1.3,
                    fontColor: ColorUtilsV2.hex_AEAEB7,
                    fontWeight: FontWeight.w500,
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
