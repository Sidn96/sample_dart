import 'package:common/core/presentation/widgets/retire100_images_asset_widget.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

class ClipImageWidget extends StatelessWidget {
  final String imagePath;

  const ClipImageWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: Sizes.screenWidth() * 0.098,
      backgroundColor: Colors.white,
      child: Retire100SvgImageAssetWidget(
        isNetwork: true,
        path: imagePath,
        height: 80,
        width: 80,
        boxFit: BoxFit.fill,
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return CircleAvatar(
  //     radius: Sizes.screenWidth() * 0.11,
  //     backgroundColor: ColorUtils.lightYellow,
  //     child: CircleAvatar(
  //       radius: Sizes.screenWidth() * 0.102,
  //       backgroundColor: ColorUtils.recommendedYellowColor,
  //       child: CircleAvatar(
  //         radius: Sizes.screenWidth() * 0.098,
  //         backgroundColor: Colors.white,
  //         child: Retire100SvgImageAssetWidget(
  //           isNetwork: true,
  //           path: imagePath,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
