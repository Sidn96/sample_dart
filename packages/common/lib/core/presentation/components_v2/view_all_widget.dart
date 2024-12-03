import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewAllWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const ViewAllWidget({super.key, this.text = 'View All', this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextV2(
              data: text,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontColor: ColorUtilsV2.hex_4E52F8,
              textAlign: TextAlign.center,
            ),
            const SizedBox(width: 9.0),
            SvgPicture.asset(AssetUtils.iconViewAll,package: "common",)
          ],
        ),
      ),
    );
  /*  return TextButton.icon(
      onPressed: onPressed,
      label: const AppImage(imgPath: AssetUtils.iconViewAll),
      icon:
    );*/
  }
}
