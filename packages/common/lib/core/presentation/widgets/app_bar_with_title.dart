import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/widgets/app_title_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBarWithTitle extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Function()? onLeadingTap;

  const AppBarWithTitle({
    super.key,
    this.title,
    this.onLeadingTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: AppTitleText(title: title ?? ""),
      backgroundColor: ColorUtilsV2.hex_F5F5FF,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: ColorUtilsV2.specialNeutral900,
        ),
        iconSize: 14,
        onPressed: () {
          onLeadingTap?.call() ?? {if (context.canPop()) context.pop()};
        },
      ),
      centerTitle: true,
    );
  }
}
