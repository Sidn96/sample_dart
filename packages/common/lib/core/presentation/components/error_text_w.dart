import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/utils/app_images.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:common/core/presentation/widgets/retire100_images_asset_widget.dart';
import 'package:flutter/material.dart';

class ErrorTextW extends StatelessWidget {
  const ErrorTextW({
    super.key,
    required this.errorMessage,
  });

  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Retire100SvgImageAssetWidget(
            path: AppImages.iconError,
            height: 14,
            width: 14,
            package: "common",
          ),
          4.width,
          AppText(
            data: errorMessage!,
            fontSize: 11.0,
            fontColor: ColorUtils.errorColor,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.024,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
