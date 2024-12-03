import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:flutter/material.dart';

class MyProfileTabBarView extends StatelessWidget {
  const MyProfileTabBarView({
    super.key,
    required this.tabController,
    required this.selectedTab,
    this.onTabChanged,
  });

  final TabController tabController;
  final int selectedTab;
  final Function(int)? onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(width: 1, color: ColorUtils.kGreyBorderColor))),
      child: SizedBox(
          width: double.maxFinite,
          height: 50,
          child: TabBar(
              controller: tabController,
              splashFactory: NoSplash.splashFactory,
              indicatorColor: ColorUtils.blueishPurpleColor,
              indicator: UnderlineTabIndicator(
                  borderSide: const BorderSide(
                      width: 1.5, color: ColorUtils.blueishPurpleColor),
                  borderRadius: BorderRadius.circular(10)),
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              onTap: (value) {
                onTabChanged?.call(value);
              },
              tabs: [
                Tab(
                    child: AppText(
                        data: AppConstants.accountDetails,
                        fontSize: Sizes.textSize14,
                        fontColor: (selectedTab == 0)
                            ? ColorUtils.blueishPurpleColor
                            : ColorUtils.kGreyDarkColor,
                        fontWeight: (selectedTab == 0)
                            ? FontWeight.w600
                            : FontWeight.w400)),
                Tab(
                    child: AppText(
                        data: AppConstants.bankAccounts,
                        fontSize: Sizes.textSize14,
                        fontColor: (selectedTab == 1)
                            ? ColorUtils.blueishPurpleColor
                            : ColorUtils.kGreyDarkColor,
                        fontWeight: (selectedTab == 1)
                            ? FontWeight.w600
                            : FontWeight.w400)),
                Tab(
                    child: AppText(
                        data: AppConstants.autoPay,
                        fontSize: Sizes.textSize14,
                        fontColor: (selectedTab == 2)
                            ? ColorUtils.blueishPurpleColor
                            : ColorUtils.kGreyDarkColor,
                        fontWeight: (selectedTab == 2)
                            ? FontWeight.w600
                            : FontWeight.w400)),
                Tab(
                    child: AppText(
                        data: AppConstants.familyDetails,
                        fontSize: Sizes.textSize14,
                        fontColor: (selectedTab == 3)
                            ? ColorUtils.blueishPurpleColor
                            : ColorUtils.kGreyDarkColor,
                        fontWeight: (selectedTab == 3)
                            ? FontWeight.w600
                            : FontWeight.w400)),
              ])),
    );
  }
}
