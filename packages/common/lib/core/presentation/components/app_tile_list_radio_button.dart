import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:flutter/material.dart';

class AppTileRadioButton<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final Function(T)? onChanged;
  final Widget customTitle;
  final double? scaleRadioSize;
  final bool alignRadioCentre;

  const AppTileRadioButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.customTitle,
    this.scaleRadioSize = 1.0,
    this.alignRadioCentre = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: alignRadioCentre
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Transform.scale(
          scale: scaleRadioSize,
          child: Radio(
            value: value,
            activeColor: ColorUtils.kBlueColor,
            groupValue: groupValue,
            onChanged: (value) {
              onChanged?.call(value as T);
            },
          ),
        ),
        Expanded(child: customTitle)
      ],
    );
  }
}
