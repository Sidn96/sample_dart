import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/widgets.dart';

class ErrorAppText extends StatelessWidget {
  final String? errorText;
  final Color? errorTextColor;
  final double? lineHeight;
  const ErrorAppText({
    super.key,
    this.errorText,
    this.errorTextColor,
    this.lineHeight,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextV2(
      data: errorText ?? '',
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontColor: errorTextColor ?? ColorUtils.errorColor,
      textAlign: TextAlign.left,
      height: lineHeight,
    );
  }
}
