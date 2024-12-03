import 'package:collection/collection.dart';
import 'package:common/core/presentation/routing/global_navigation_utils.dart';
import 'package:common/core/presentation/routing/route_strings.dart';
import 'package:common/core/presentation/services/moengage_service_truefin.dart';
import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/mo_engage_events_const.dart';
import 'package:common/features/bottom_navbar/domain/bottom_nav_bar_item_model.dart';
import 'package:common/features/bottom_navbar/presentation/widgets/bottom_navbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bottom_nav_bar_provider.g.dart';

final List<BottomNavBarItemModel> bottomNavbarItemList = [
  BottomNavBarItemModel(
      routeName: "/",
      itemName: AppConstants.homeLabel,
      navItemUnselectedImagePath: AssetUtils.icHomeNavUnSelected,
      navItemSelectedImagePath: AssetUtils.icHomeNavSelected),
  BottomNavBarItemModel(
      routeName: "/nps",
      itemName: AppConstants.npsLabel,
      navItemUnselectedImagePath: AssetUtils.icInvestNavUnSelected,
      navItemSelectedImagePath: AssetUtils.icInvestNavSelected),

  //used for empty space on which to show logo
  BottomNavBarItemModel(
      routeName: "",
      itemName: AppConstants.logoItemEmptySpacelabel,
      navItemUnselectedImagePath: "",
      navItemSelectedImagePath: ""),

  BottomNavBarItemModel(
      routeName: "/blog-videos-listing",
      itemName: AppConstants.contentLabel,
      navItemUnselectedImagePath: AssetUtils.icContentNavUnSelected,
      navItemSelectedImagePath: AssetUtils.icContentNavSelected),
  BottomNavBarItemModel(
      routeName: "/services",
      itemName: AppConstants.servicesLabel,
      navItemUnselectedImagePath: AssetUtils.icServicesNavUnSelected,
      navItemSelectedImagePath: AssetUtils.icServicesNavSelected),
];

//provider for controlling the main nav bar visibility and also controls the selected navbar item
@Riverpod(keepAlive: true)
class BottomNavBarStateNotifier extends _$BottomNavBarStateNotifier {
  bool doManualVisibilityHandling = false;
  String currentRouteName = "";

  //pages list where navbar will be shown
  List<String> pagesToShowNavBar = [
    "/nps",
    // "/dashboard",
    // "/dashboard/true",
    //"/dashboard/false",
    "/blog-videos-listing",
    "/services",
    "/",
    //  "/epf",
    CommonRouteString.oneviewScreen
  ];

  autoSelectNavBarItem(TabController tabController) {
    try {
      final String shouldactiveTab = pagesToShowNavBar.firstWhere(
          (bottonTab) => currentRouteName.contains(bottonTab),
          orElse: () => "NA");

      if (currentRouteName == CommonRouteString.oneviewScreen) return;

      final index = bottomNavbarItemList
          .indexWhere((model) => model.routeName == shouldactiveTab);

      if (index != -1) {
        if (currentRouteName == (CommonRouteString.oneviewScreen)) return;

        final item = bottomNavbarItemList[index];

        if (state.selectedNavBarItem == item) return;

        setSelectedNavBarItemAndNavigate(item, index, tabController,
            callNavigator: false);
      }
    } catch (e) {
      // nothing to do
    }
  }

  @override
  BottomNavBarState build() {
    //setting home as initial location for bottom nav bar
    return BottomNavBarState(
        showNavBar: true, selectedNavBarItem: bottomNavbarItemList.first);
  }

  //checks if already hidden if yes then returns else hides
  checkAndHideNavBar() {
    if (state.showNavBar == false) return;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      state = state.copyWith(showNavBar: false);
    });
  }

  //checks if the navbar is already visible if yes returns else makes it visible
  checkAndShowNavBar() {
    if (state.showNavBar == true) return;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      state = state.copyWith(showNavBar: true);
    });
  }

  //
  checkIfCurrentPageNeedsNavBarAndShow({currentPage}) {
    if (doManualVisibilityHandling == true) return;
    if (currentPage.contains(CommonRouteString.oneviewScreen)) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        state = state.copyWith(
            hideNavIndicator: true,
            showNavBar: false,
            navBarItemModel: bottomNavbarItemList.firstWhereOrNull((element) =>
                element.itemName == AppConstants.logoItemEmptySpacelabel));
      });
    } else {
      currentRouteName = currentPage;
      if (state.hideNavIndicator == true) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          state = state.copyWith(hideNavIndicator: false);
        });
      }
    }
    if (pagesToShowNavBar.contains(currentPage)) {
      if (state.selectedNavBarItem.routeName != currentPage) {
        BottomNavBarItemModel? item = bottomNavbarItemList
            .firstWhereOrNull((element) => element.routeName == currentPage);

        if (item != null) {
          int itemIndex = bottomNavbarItemList.indexOf(item);
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            state = state.copyWith(navBarItemModel: item);
            if (bottomNavTabController != null) {
              bottomNavTabController?.animateTo(itemIndex);
            }
          });
        }
      }
      //show navbar
      checkAndShowNavBar();
    } else {
      //hide navbar
      checkAndHideNavBar();
    }
  }

  navigateToRoute(String route) {
    GoRouter.of(GlobalNavigationUtils.rootAppNavigatorKey.currentContext!)
        .go(route);
  }

  //
  setManualVisibilityHandling(bool value) {
    if (doManualVisibilityHandling == value) return;
    doManualVisibilityHandling = value;
  }

  //for setting selected nav bar item
  setSelectedNavBarItemAndNavigate(
      BottomNavBarItemModel item, int index, TabController tabController,
      {bool callNavigator = true}) {
    String selectionType = '';
    if (item.itemName == AppConstants.homeLabel) {
      selectionType = MoEngageEventsConsts.eventAttributesValue.truefinHomepage;
    } else if (item.itemName == AppConstants.contentLabel) {
      selectionType = MoEngageEventsConsts.eventAttributesValue.contentCentre;
    } else if (item.itemName == AppConstants.servicesLabel) {
      selectionType = MoEngageEventsConsts.eventAttributesValue.services;
    }

    MoEngageService().trackEvent(
        eventName: MoEngageEventsConsts.eventsNames.truefinHomepageCtaClicked,
        product: ProductEvent.truefin,
        properties: {"selection": item.itemName});

    //check if item is already selected if yes return
    if (state.selectedNavBarItem == item) return;
    state = state.copyWith(navBarItemModel: item);
    tabController.animateTo(index);
    if (callNavigator) navigateToRoute(item.routeName);
    setManualVisibilityHandling(false);
  }

  //for updating the nav bar visibility
  updateNavBarVisibility(bool isVisible) {
    if (state.showNavBar == isVisible) return;
    state = state.copyWith(showNavBar: isVisible);
  }
}
