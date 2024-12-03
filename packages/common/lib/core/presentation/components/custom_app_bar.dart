import 'package:common/core/presentation/components_v2/text_styles.dart';
import 'package:flutter/material.dart';

import '../styles/color_utils.dart';
import '../styles/font_styles.dart';
import '../styles/sizes.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Function? onLeadingTap;
  final bool isBackButtonShowing;
  final Color? backgroundColor;
  final String title;
  final List<Widget>? actionWidgets;
  final Color leadingIconColor;
  final Color titleColor;
  final bool centerTitle;
  final double letterSpacing;
  final double leadingWidth;
  final double xAxisTranslateValue;
  final bool titleNeedManRopeStyle;

  const CustomAppbar(
      {Key? key,
      this.onLeadingTap,
      this.backgroundColor,
      required this.title,
      this.actionWidgets,
      this.centerTitle = false,
      this.isBackButtonShowing = true,
      this.leadingIconColor = ColorUtils.white,
      this.titleColor = Colors.white,
      this.letterSpacing = 0.9,
      this.leadingWidth = 40,
      this.xAxisTranslateValue = 0,
      this.titleNeedManRopeStyle = false})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(55.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      leading: Visibility(
        visible: isBackButtonShowing,
        child: InkWell(
          onTap: onLeadingTap as void Function()?,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: leadingIconColor,
              size: Sizes.textSize16,
            ),
          ),
        ),
      ),
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor ?? ColorUtils.kBlueColor,
      leadingWidth: leadingWidth,
      titleSpacing: 0,
      centerTitle: centerTitle,
      title: Transform.translate(
        offset: Offset(xAxisTranslateValue, 0),
        child: Text(
          title,
          style: titleNeedManRopeStyle
              ? TextStyles.manropeStyle(Sizes.textSize16,
                  color: titleColor,
                  fontWeight: FontWeight.w500,
                  letterSpacing: letterSpacing)
              : FontStyles.interStyle(
                  fontSize: Sizes.textSize16,
                  textColor: titleColor,
                  fontWeight: FontWeight.w700,
                  letterSpacing: letterSpacing),
        ),
      ),
      actions: actionWidgets,
    );
  }
}
