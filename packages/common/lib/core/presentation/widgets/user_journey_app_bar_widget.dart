import 'package:common/core/presentation/components/custom_app_bar.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserJourneyAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onLeadingTap;
  final Color? bgColor;

  const UserJourneyAppBarWidget(
      {super.key,
      required this.title,
      this.showBackButton = true,
      this.bgColor,
      this.onLeadingTap});

  @override
  Size get preferredSize => const Size.fromHeight(55.0);

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
      title: title,
      onLeadingTap: () {
        if (onLeadingTap != null) {
          onLeadingTap!();
        } else {
          context.pop();
        }
      },
      backgroundColor: bgColor ?? ColorUtils.white2,
      leadingIconColor: ColorUtils.black,
      titleColor: ColorUtils.black,
      letterSpacing: 0.3,
      centerTitle: true,
      isBackButtonShowing: showBackButton,
    );
  }
}
