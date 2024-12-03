import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/core/presentation/extensions/string_extensions.dart';
import 'package:common/core/presentation/utils/app_images.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/retire100_images_asset_widget.dart';

class SuggestedAddresCardDetailWidget extends StatelessWidget {
  final String tite;
  final String description;

  const SuggestedAddresCardDetailWidget({
    super.key,
    required this.tite,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Retire100SvgImageAssetWidget(
              path: AppImages.locatemappin,
              package: "common",
            ),
            7.width,
            SizedBox(
              width: Sizes.screenWidth() * 0.7,
              child: AppText(
                data: tite,
                fontSize: 14,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        5.height,
        AppText(
          data: description.toTitleCase().trim(),
          height: 1.4,
          fontSize: 14,
          textAlign: TextAlign.start,
          fontWeight: FontWeight.w400,
          fontColor: ColorUtils.midLightGrey,
        ),
      ],
    );
  }
}
