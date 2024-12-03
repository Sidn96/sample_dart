import 'package:common/core/presentation/services/moengage_service_truefin.dart';
import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/mo_engage_events_const.dart';
import 'package:common/core/presentation/widgets/image_util.dart';
import 'package:common/features/navigation_drawer/presentation/drawer_bottom_sheet_widget.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../components_v2/color_utils_v2.dart';
import '../utils/app_images.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 24.0),
          GestureDetector(
              onTap: () {
                openDrawerMenuAsBottomSheet(context);
              },
              child: SvgPicture.asset(AppImages.profileIcon)),
          // GestureDetector(
          //     onTap: () {
          //       drawerScaffoldKey.currentState?.openDrawer();
          //     },
          //     child: SvgPicture.asset(AppImages.drawerMenuIcon)),
          const Spacer(),
          SvgPicture.asset(AppImages.searchIcon),
          const SizedBox(width: 20.0),
          SvgPicture.asset(AppImages.notificationIcon),
          const SizedBox(width: 20.0)
          //const SizedBox(width:19.0),
        ],
      ),
    );
  }
}

class CommonTrueFinSliverAppBar extends StatelessWidget {
  final bool needBackButton;
  final Color? backGroundColor;
  final Map<String, dynamic>? params;

  const CommonTrueFinSliverAppBar(
      {super.key,
      this.needBackButton = false,
      this.backGroundColor,
      this.params});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: backGroundColor ?? Colors.transparent,
      leadingWidth: 20.0,
      title: Align(
        alignment: Alignment.centerLeft,
        child: ExpandTapWidget(
          onTap: () {
            if (needBackButton) {
              context.pop();
            } else {
              MoEngageService().trackEvent(
                  eventName: MoEngageEventsConsts
                      .eventsNames.truefinhamburgerscreenviewed,
                  product: ProductEvent.truefin,
                  properties: {
                    MoEngageEventsConsts.eventAttributesKey.screenViewed:
                        MoEngageEventsConsts.eventAttributesValue.hamburgerMenu,
                  });
              openDrawerMenuAsBottomSheet(context, params: params);
            }
          },
          tapPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: needBackButton
              ? ImageUtil.load(
                  AssetUtils.arrowBackIcon,
                  color: ColorUtilsV2.specialNeutral900,
                )
              : SvgPicture.asset(
                  AppImages.profileIcon,
                  height: 30.0,
                ),
        ),
      ),
      titleSpacing: 0.0,
      leading: const SizedBox(width: 20.0),
      actions: const [
        /* SvgPicture.asset(AppImages.searchIcon),
        const SizedBox(width: 20.0),*/
        /*  SvgPicture.asset(AppImages.notificationIcon),
        const SizedBox(width: 20.0),*/
      ],
    );
  }
}
