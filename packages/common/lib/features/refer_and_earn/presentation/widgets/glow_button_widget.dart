import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:flutter/material.dart';

class GlowButtonWidget extends StatelessWidget {
  final String title;
  final Color primaryColor;
  final Function()? onTap;
  final String? iconPath;
  const GlowButtonWidget({
    super.key,
    required this.title,
    required this.primaryColor,
    this.iconPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 330,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.6),
              blurRadius: 16.0,
              spreadRadius: 1.0,
              offset: const Offset(0.0, 0.0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPath != null) ...[
              Image(
                  image: AssetImage(iconPath!, package: "common"), height: 30),
              const SizedBox(width: 10)
            ],
            AppTextV2(
              data: title,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
