import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({super.key, required this.onTap});
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorUtils.kOffWhiteColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      // title: const AppImage(
      //   imgPath: AssetUtils.retire100BlueLogo,
      //   isSvg: true,
      // ),
      title: SvgPicture.asset(AssetUtils.retire100BlueLogo, height: 80),
      actions: [
        Transform.scale(
          scale: 0.7,
          child: SvgPicture.asset(AssetUtils.profileLogo),
          // child: const AppImage(
          //   imgPath: AssetUtils.profileLogo,
          //   isSvg: false,
          // ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: onTap,
          child: const AppImage(
            imgPath: AssetUtils.drawerIcon,
            isSvg: true,
          ),
        ),
        const SizedBox(width: 20)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55.0);
}
