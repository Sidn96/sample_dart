import 'package:common/core/presentation/components_v2/components_v2.dart';
import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:flutter/material.dart';

class BulletedText extends StatelessWidget {
  final String? number;
  final Widget? bullet;
  final int? space;
  final String? text;
  final Color? fontColor;
  const BulletedText({super.key, this.number, this.text, this.bullet, this.space, this.fontColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        bullet ??
            AppTextV2(
              data: number != null ? "$number." : "",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.start,
              fontColor: fontColor ?? ColorUtilsV2.specialNeutral500,
            ),
        space != null ? space.width : 5.width,
        Expanded(
          child: AppTextV2(
            data: text ?? "",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.start,
            fontColor: fontColor ?? ColorUtilsV2.specialNeutral500,
          ),
        ),
      ],
    );
  }
}
