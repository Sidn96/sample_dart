import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:flutter/material.dart';

import '../styles/app_assets.dart';
import '../styles/sizes.dart';
import '../widgets/image_util.dart';

class VerifiedWidget extends StatelessWidget {
  final String text;

  const VerifiedWidget({Key? key, this.text = 'Verified'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        height: 24.40,
        padding:
            const EdgeInsets.only(left: 8, bottom: 4.43, top: 3.97, right: 8),
        decoration: BoxDecoration(
            color: ColorUtilsV2.specialNeutral600,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageUtil.load(AssetUtils.iconVerified,
                  fit: BoxFit.fitWidth, height: 15),
              const SizedBox(width: 5),
              AppTextV2(
                data: text,
                fontSize: Sizes.textSize12,
                textAlign: TextAlign.start,
                fontColor: ColorUtilsV2.specialSuccess300,
                maxLines: 1,
              )
            ]),
      ),
    );
  }
}
