import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:flutter/material.dart';

class AppOutlinedButton extends StatelessWidget {
  final Function()? onPressed;
  final String? label;
  final Color? outlineColor;
  final Color? labelColor;
  final double? width;
  final double? height;
  final Widget? child;
  final Color? bgColor;
  const AppOutlinedButton({
    super.key,
    this.onPressed,
    this.label,
    this.outlineColor,
    this.height,
    this.width,
    this.child,
    this.bgColor,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: TextButton(
        style: ButtonStyle(
          padding:
              WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
          foregroundColor:
              WidgetStateProperty.all<Color>(ColorUtilsV2.hex_4E52F8),
          backgroundColor:
              bgColor != null ? WidgetStateProperty.all<Color>(bgColor!) : null,
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(
                  width: 1.5, color: outlineColor ?? ColorUtilsV2.hex_4E52F8),
            ),
          ),
        ),
        onPressed: onPressed,
        child: child ??
            AppTextV2(
              data: label ?? "",
              fontSize: 14,
              fontColor: labelColor,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
