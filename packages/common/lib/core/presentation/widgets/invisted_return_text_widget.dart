import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/widgets/app_tool_tip_widget.dart';
import 'package:flutter/material.dart';

class InvestedReturnTextWidget extends StatelessWidget {
  final String title, value;
  final Color? valueColor;
  final Color? titleColor;
  final double? valueSize;
  final String? toolTipText;

  const InvestedReturnTextWidget({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
    this.titleColor,
    this.valueSize,
    this.toolTipText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AppTextV2(
              data: title,
              fontSize: 12,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w400,
              fontColor: titleColor ?? ColorUtilsV2.hex_AEAEB7,
            ),
            if (toolTipText != null) ...[
              const SizedBox(width: 5),
              AppToolTipWidget(
                toolTipContentWidget: SizedBox(
                  width: Sizes.screenWidth() * .3,
                  child: AppTextWithoutAutoSize(
                      data: toolTipText ?? '',
                      textAlign: TextAlign.start,
                      fontSize: Sizes.textSize12),
                ),
                preferredDirection: AxisDirection.up,
                toolTipWidget: const Icon(
                  Icons.info,
                  color: ColorUtilsV2.hex_C2C2C9,
                  size: 12,
                ),
              ),
            ],
          ],
        ),
        AppTextV2(
          data: value,
          fontSize: valueSize ?? 14,
          textAlign: TextAlign.start,
          fontWeight: FontWeight.w500,
          fontColor: valueColor,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
