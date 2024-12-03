import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

class WhyReferFriend extends StatelessWidget {
  const WhyReferFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        children: [
          const AppTextV2(
            data: AppConstants.whyreferfriend,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            fontColor: Colors.white,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: ColorUtilsV2.hex_2563EB),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const AppTextV2(
              data: AppConstants.whyreferfriendDesc,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 1.4,
              fontColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
