import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:flutter/material.dart';

class AnswerSelectionWidget extends StatelessWidget {
  final Widget labelWidget;
  final Color selectedOptionColor;
  final bool isOptionSelected;
  final Function()? onTap;
  final int index;

  const AnswerSelectionWidget(
      {super.key,
      required this.index,
      required this.selectedOptionColor,
      this.onTap,
      required this.labelWidget,
      required this.isOptionSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () => onTap?.call(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ///main circle widget
            Container(
              height: 96,
              width: 96,
              margin: const EdgeInsets.symmetric(horizontal: 12.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: ColorUtils.hex35354D),
                shape: BoxShape.circle,
                color: selectedOptionColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Center(child: labelWidget),
              ),
            ),

            ///blue circle
            Positioned(
              top: 0,
              bottom: 0,
              left: 1,
              child: Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                  color: ColorUtils.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: isOptionSelected
                          ? ColorUtils.blueishPurpleColor
                          : ColorUtils.hex35354D),
                ),
                child: isOptionSelected
                    ? const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: CircleAvatar(
                            backgroundColor: ColorUtils.blueishPurpleColor),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
