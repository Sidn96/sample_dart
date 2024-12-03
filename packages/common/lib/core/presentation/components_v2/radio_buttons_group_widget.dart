import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:common/core/presentation/components/app_radio_button.dart';

class RadioButtonsGroupWidget extends HookWidget {
  final List<String> dataList;
  final String? selectedValue;
  final Function(String) onChanged;

  /// Space between two radio button widgets Horizontally
  final double spacing;

  /// Space between two radio button widgets Vertically
  final double runSpacing;

  /// Space between Radio_Button and Text
  final double? inBetweenSpace;
  final double innerRadius;
  final double outerRadius;
  final double strokeWidth;
  final double fontSize;

  const RadioButtonsGroupWidget({
    super.key,
    required this.onChanged,
    required this.dataList,
    this.selectedValue,
    this.spacing = 12,
    this.runSpacing = 4,
    this.inBetweenSpace = 4,
    this.innerRadius = 5,
    this.outerRadius = 12,
    this.strokeWidth = 1,
    this.fontSize=12.0
  });

  @override
  Widget build(BuildContext context) {
    var groupValue = useState<String>(selectedValue ?? "");

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          runSpacing: runSpacing,
          spacing: spacing,
          children: [
            for (var s in dataList)
              AppRadioButton(
                fontSize: fontSize,
                value: s,
                groupValue: groupValue.value,
                onChanged: (val) {
                  groupValue.value = val!;
                  onChanged.call(val);
                },
                inBetweenSpace: inBetweenSpace,
                innerRadius: innerRadius,
                outerRadius: outerRadius,
                strokeWidth: strokeWidth,
              )
          ],
        ),
      ],
    );
  }
}
