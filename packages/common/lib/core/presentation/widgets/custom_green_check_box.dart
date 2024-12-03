import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

class CustomGreenCheckBox extends StatelessWidget {
  final Function(bool?)? onChanged;
  final MaterialTapTargetSize? materialTapTargetSize;
  final bool? value;
  final Color? unCheckColor;
  final Color? checkColor;
  const CustomGreenCheckBox(
      {super.key,
      required this.value,
      required this.onChanged,
      this.unCheckColor,
      this.checkColor,
      this.materialTapTargetSize});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0),
          side:
              BorderSide(color: unCheckColor ?? ColorUtils.kbuttondisableText)),
      side: MaterialStateBorderSide.resolveWith((states) => BorderSide(
          width: 1.0, color: unCheckColor ?? ColorUtils.kbuttondisableText)),
      materialTapTargetSize:
          materialTapTargetSize ?? MaterialTapTargetSize.shrinkWrap,
      activeColor: checkColor ?? ColorUtils.black,
    );
  }
}
