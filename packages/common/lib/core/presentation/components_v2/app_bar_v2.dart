import 'package:common/core/presentation/components_v2/components_v2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../styles/app_assets.dart';
import '../widgets/image_util.dart';

class AppBarV2 extends StatelessWidget implements PreferredSizeWidget {
  final double toolbarHeight;
  final String title;
  final Color titleColor;
  final double titleSize;
  final double titleSpacing;
  final FontWeight titleWeight;
  final Color backgroundColor;
  final Function()? onLeadingTap;
  final Function()? onLeadingTap2;
  final List<Widget>? actionWidgets;
  final bool centerTitle;
  final Widget? leadingWidget;
  final Widget? backButtonWidget;
  final PreferredSizeWidget? bottom;
  final bool isUseDefaultPop;

  const AppBarV2({
    Key? key,
    this.toolbarHeight = 70,
    this.title = '',
    this.titleColor = ColorUtilsV2.specialNeutral700,
    this.titleSize = 16,
    this.titleWeight = FontWeight.w500,
    this.backgroundColor = ColorUtilsV2.specialBackground50,
    this.onLeadingTap,
    this.onLeadingTap2,
    this.actionWidgets,
    this.centerTitle = true,
    this.leadingWidget,
    this.titleSpacing = 16.0,
    this.backButtonWidget,
    this.bottom,
    this.isUseDefaultPop = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      toolbarHeight: toolbarHeight,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      bottom: bottom,
      leading: backButtonWidget ??
          CupertinoButton(
            onPressed: isUseDefaultPop
                ? () {
                  onLeadingTap?.call() ?? context.pop();
                }
                : onLeadingTap ?? () => context.pop(),
            padding: EdgeInsets.zero,
            child: ImageUtil.load(
              AssetUtils.arrowBackIcon,
              color: ColorUtilsV2.specialNeutral900,
            ),
          ),
      title: leadingWidget ??
          AppTextV2(
            data: title,
            fontColor: titleColor,
            fontSize: titleSize,
            fontWeight: titleWeight,
            height: 1,
            letterSpacing: -0.32,
          ),
      actions: actionWidgets,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
