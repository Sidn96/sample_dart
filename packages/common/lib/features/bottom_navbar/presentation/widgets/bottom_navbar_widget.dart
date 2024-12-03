import 'package:common/core/presentation/components/custom_round_tab_indicator.dart';
import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/features/bottom_navbar/domain/bottom_nav_bar_item_model.dart';
import 'package:common/features/bottom_navbar/presentation/providers/bottom_nav_bar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const double bottomNavBarHeight = 80.0;
const double icLogoWidgetSize = 76.0;

TabController? bottomNavTabController;

class BottomNavBarWidget extends HookConsumerWidget {
  const BottomNavBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 5);
    BottomNavBarState navBarState =
        ref.watch(bottomNavBarStateNotifierProvider);
    BottomNavBarItemModel selectedItem = navBarState.selectedNavBarItem;
    useEffect(() {
      bottomNavTabController = tabController;
      /*  tabController.addListener(() {
        //disables the tab bar beyond two items
        if (tabController.index > 1) {
          tabController.animateTo(tabController.previousIndex);
        }
      }); */

      return () {
        debugPrint("bottom navbar view disposed");
        bottomNavTabController = null;
      };
    }, []);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref
            .read(bottomNavBarStateNotifierProvider.notifier)
            .autoSelectNavBarItem(tabController);
      });
      return null;
    }, []);

    return SizedBox(
        // curve: Curves.easeInOut,
        // duration: const Duration(milliseconds: 500),
        width: MediaQuery.of(context).size.width,
        height: bottomNavBarHeight,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: bottomNavBarHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 8.0,
                  offset: const Offset(0, -5),
                  color: Colors.black.withOpacity(0.1))
            ],
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12.0),
              topLeft: Radius.circular(12.0),
            ),
          ),
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: CustomRoundedTabIndicator(
                color: navBarState.hideNavIndicator
                    ? Colors.transparent
                    : ColorUtilsV2.hex_4ADE80),
            labelPadding: const EdgeInsets.only(bottom: 8.0),
            padding: EdgeInsets.zero,
            indicatorPadding: const EdgeInsets.only(bottom: 11.0),
            onTap: (index) {
              /*  if (index > 1) return; */
              ref
                  .read(bottomNavBarStateNotifierProvider.notifier)
                  .setSelectedNavBarItemAndNavigate(
                      bottomNavbarItemList[index], index, tabController);
            },
            controller: tabController,
            tabs: [
              for (int i = 0; i < bottomNavbarItemList.length; i++)
                if (bottomNavbarItemList[i].itemName ==
                    AppConstants.logoItemEmptySpacelabel)
                  const SizedBox(width: icLogoWidgetSize)
                else
                  SizedBox(
                    width: double.infinity,
                    child: Builder(
                      builder: (BuildContext context) {
                        BottomNavBarItemModel item = bottomNavbarItemList[i];
                        bool isItemSelected = item == selectedItem;
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(isItemSelected
                                  ? item.navItemSelectedImagePath
                                  : item.navItemUnselectedImagePath),
                              const SizedBox(height: 8.0),
                              AppTextV2(
                                data: item.itemName,
                                fontSize: 12.0,
                                height: 1.0,
                                fontColor: isItemSelected
                                    ? ColorUtilsV2.hex_35354D
                                    : ColorUtilsV2.hex_5D5D70,
                                fontWeight: isItemSelected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
            ],
          ),
        ));
  }
}

class IcNavLogoWidget extends StatelessWidget {
  const IcNavLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: icLogoWidgetSize,
      height: icLogoWidgetSize,
      decoration: BoxDecoration(
          color: ColorUtilsV2.hex_7375FD,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.33), blurRadius: 7.0)
          ]),
      child: Center(
        child: Container(
          height: icLogoWidgetSize - 3.0,
          width: icLogoWidgetSize - 3.0,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: ColorUtilsV2.hex_F9FAFB),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SvgPicture.asset(
              AssetUtils.icLogoSmall,
              width: 41.0,
              height: 36.79,
            ),
          )),
        ),
      ),
    );
  }
}
