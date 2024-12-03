import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:flutter/material.dart';

/// Rounded green(default) chip with text
class RoundedChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  Color? labelColor;
  TextStyle? textStyle;

  final VoidCallback? onPressed;

  RoundedChip({
    Key? key,
    required this.label,
    required this.isSelected,
    this.labelColor,
    this.textStyle,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () {},
      child: Chip(
        label: Text(
          label,
          style: textStyle ?? TextStyle(color: labelColor ?? Colors.black),
        ),
        backgroundColor: isSelected
            ? ColorUtilsV2.specialSuccess300
            : ColorUtilsV2.specialBackground50,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey), // Border color and width
          borderRadius:
              BorderRadius.circular(20.0), // Adjust the radius as needed
        ),
      ),
    );
  }
}
