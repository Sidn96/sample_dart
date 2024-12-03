import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginRegisterAppBar extends StatelessWidget implements PreferredSizeWidget {

  const LoginRegisterAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Stack(
        children: [
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              onPressed: () => context.pop(),
              icon: const AppImage(
                imgPath: AssetUtils.closeIcon,
                height: 16,
                width: 16,
                iconColor: ColorUtils.black,
              ),
            ),
          ),
          const Positioned.fill(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: EdgeInsets.only(left: 18),
                child: AppImage(
                  imgPath: AssetUtils.retire100BlueLogo,
                  package: "common",
                  height: 34,
                  width: 63.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
