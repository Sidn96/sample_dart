import 'package:common/core/presentation/components_v2/components_v2.dart';
import 'package:flutter/material.dart';

class RoundedOutlinedButton extends StatelessWidget {
  final String label;
  final Function()? onPressed;
  final bool isEnable;
  const RoundedOutlinedButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.isEnable = true});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: OutlinedButton(
        onPressed: isEnable ? onPressed : null,
        style: OutlinedButton.styleFrom(
            side: BorderSide(
                color: isEnable
                    ? ColorUtilsV2.hex_4E52F8
                    : ColorUtilsV2.hex_C2C2C9),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        child: AppTextV2(
          data: label,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontColor:
              isEnable ? ColorUtilsV2.hex_4E52F8 : ColorUtilsV2.hex_C2C2C9,
        ),
      ),
    );
  }
}
