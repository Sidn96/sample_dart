import 'package:flutter/material.dart';

import '../styles/color_utils.dart';

class CustomCheckBox extends StatelessWidget {
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  const CustomCheckBox({this.value,this.onChanged,super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(unselectedWidgetColor: ColorUtils.greyColor),
      child: Checkbox(
        value: value,
        onChanged: onChanged,
        activeColor: ColorUtils.kGreenLightColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
