import 'package:common/core/presentation/widgets/retire100_images_asset_widget.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

class HelpSupportTilesWidget extends StatelessWidget {
  final String label;
  final String description;
  final String imgPath;
  final String metaData;
  final String? metaData2;
  final VoidCallback? onMetaDataPressed;
  final VoidCallback? onMetaData2Pressed;
  const HelpSupportTilesWidget({
    super.key,
    required this.label,
    required this.description,
    required this.imgPath,
    required this.metaData,
    this.metaData2,
    this.onMetaDataPressed,
    this.onMetaData2Pressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              data: label,
              fontSize: 14,
              fontColor: ColorUtils.kBlackLightColor,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 10),
            AppText(
              data: description,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: onMetaDataPressed,
              child: AppText(
                data: metaData,
                fontSize: 14,
                fontColor: ColorUtils.kBlueColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (metaData2 != null) ...[
              const SizedBox(height: 15),
              GestureDetector(
                onTap: onMetaData2Pressed,
                child: AppText(
                  data: metaData2 ?? "",
                  fontSize: 14,
                  fontColor: ColorUtils.kBlueColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ]
          ],
        ),
        const Spacer(),
        Container(
          width: 32,
          height: 32,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: ColorUtils.warningCircle,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Retire100SvgImageAssetWidget(
            path: imgPath,
            height: 20,
            width: 20,
            package: "common",
          ),
        ),
      ],
    );
  }
}
