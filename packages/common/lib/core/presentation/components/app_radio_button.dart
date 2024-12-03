import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/widgets/custom_radio.dart';
import 'package:flutter/material.dart';

class AppRadioButton extends StatelessWidget {
  final String value;

  /// Selected Value [groupValue]
  final String groupValue;
  final Function(String?)? onChanged;

  /// Space between Radio_Button and Text
  final double? inBetweenSpace;
  final double innerRadius;
  final double outerRadius;
  final double strokeWidth;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? disabledColor;
  final Color? textColor;
  final double fontSize;
  final bool? showText;

  const AppRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.inBetweenSpace = 0,
    this.innerRadius = 5,
    this.outerRadius = 12,
    this.strokeWidth = 1,
    this.activeColor = ColorUtilsV2.hex_7375FD,
    this.inactiveColor = ColorUtilsV2.specialNeutral700,
    this.textColor = ColorUtilsV2.specialNeutral700,
    this.disabledColor = ColorUtilsV2.specialNeutral400,
    this.fontSize = 12,
    this.showText = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged?.call(value),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 35,
            child: CustomRadio(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: activeColor,
              strokeWidth: strokeWidth,
              innerRadius: innerRadius,
              outerRadius: outerRadius,
              disabledColor: disabledColor,
              fillColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.disabled)) {
                  return disabledColor;
                }
                return inactiveColor;
              }),
            ),
          ),
          SizedBox(width: inBetweenSpace),
          if (showText == true)
            Flexible(
              child: AppTextV2(
                data: value,
                fontSize: fontSize,
                fontColor: onChanged == null ? disabledColor : textColor,
                fontWeight:
                    groupValue == value ? FontWeight.w600 : FontWeight.w400,
                textAlign: TextAlign.start,
              ),
            )
        ],
      ),
    );
  }
}
