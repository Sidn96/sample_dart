import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:flutter/material.dart';

class QuestionChipsWidget extends StatelessWidget {
  final String labelText;
  final Color selectedChipBgColor;
  final Color borderColor;
  final Function()? onTap;
  final int index;
  final double maxWidth;
  final double minHeight;
  final int indexChip;
  final Color disabledFontColor;

  const QuestionChipsWidget({
    super.key,
    required this.index,
    required this.selectedChipBgColor,
    this.borderColor = ColorUtilsV2.genericWhite,
    this.onTap,
    this.minHeight = 35,
    this.maxWidth = 70,
    required this.labelText,
    required this.indexChip,
    this.disabledFontColor = ColorUtilsV2.genericWhite,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: () => onTap?.call(),
        child: SizedBox(
          height: 36,
          child: Container(
            //surfaceTintColor: selectedEmpType,
            // labelPadding: EdgeInsets.zero,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: selectedChipBgColor,
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                border: Border.all(
                    color: indexChip == index
                        ? ColorUtilsV2.transparent
                        : borderColor)),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: minHeight,
                maxWidth: maxWidth,
              ),
              child: Center(
                child: AppTextV2(
                  data: labelText,
                  fontSize: Sizes.textSize12,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                  fontColor: indexChip == index
                      ? ColorUtilsV2.neutral700
                      : disabledFontColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
