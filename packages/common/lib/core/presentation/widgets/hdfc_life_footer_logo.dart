import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/widgets/common_widgets.dart';
import 'package:common/core/presentation/widgets/image_util.dart';
import 'package:flutter/material.dart';

/// HdfcLife Common Footer Logo
class HdfcLifeFooterLogo extends StatelessWidget {
  const HdfcLifeFooterLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CommonWidgets().sizedboxH8,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //commented as per NP-122 update footer logo with DigiNPS
            // ImageUtil.load(
            //   AssetUtils.footerHdfcLifeLogo,
            //   width: 86,
            //   height: 12,
            // ),
            ImageUtil.load(
              AssetUtils.digiPowerByFooterLogo,
              width: 230,
              height: 22,
            ),
          ],
        ),
        CommonWidgets().sizedboxH8,
      ],
    );
  }
}
