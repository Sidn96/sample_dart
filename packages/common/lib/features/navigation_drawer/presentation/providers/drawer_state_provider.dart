import 'package:common/core/presentation/routing/route_strings.dart';
import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/utils/app_info.dart';
import 'package:common/features/navigation_drawer/domain/drawer_item_model.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'drawer_state_provider.g.dart';

List<DrawerMenuItemModel> drawerMenuItemsList = [
  DrawerMenuItemModel(
    isSelected: false,
    name: "Products",
    childMenuList: [
      DrawerChildMenuItemModel(
        isSelected: false,
        name: "National Pension System (NPS)",
        routePath: "/nps",
        imagePath: AssetUtils.npsic,
      ),
      DrawerChildMenuItemModel(
        isSelected: false,
        name: "Mutual Funds (MF)",
        routePath: "mf_landing",
        imagePath: AssetUtils.mfic,
      ),
      DrawerChildMenuItemModel(
        isSelected: false,
        name: "Health Insurance",
        routePath: "health-insurance",
        imagePath: AssetUtils.hcic,
      ),
      DrawerChildMenuItemModel(
        isSelected: false,
        name: "Employee Provident Fund",
        routePath: "epf",
        imagePath: AssetUtils.epfic,
      ),
    ],
  ),
  DrawerMenuItemModel(
    isSelected: false,
    childMenuList: [],
    name: "My Orders",
    routePath: CommonRouteString.myOrderPage,
  ),
  DrawerMenuItemModel(
    isSelected: false,
    name: "Resources",
    childMenuList: [
      DrawerChildMenuItemModel(
        isSelected: false,
        name: "Blogs",
        routePath: "/blog-videos-listing",
        extraParams: {"showVideos": false},
        imagePath: AssetUtils.blogic,
      ),
      DrawerChildMenuItemModel(
        isSelected: false,
        name: "Videos",
        routePath: "/blog-videos-listing",
        extraParams: {"showVideos": true},
        imagePath: AssetUtils.videoic,
      ),
      // DrawerChildMenuItemModel(
      //   isSelected: false,
      //   name: "Calculators",
      //   routePath: "/content",
      //   imagePath: AssetUtils.calcic,
      // ),
    ],
  ),
  DrawerMenuItemModel(
    isSelected: false,
    name: "Services",
    childMenuList: [
      DrawerChildMenuItemModel(
        isSelected: false,
        name: "Truepal",
        routePath: "",
        isEnabled: !kIsWeb,
        imagePath: AssetUtils.truepallogo,
      ),
    ],
  ),
  DrawerMenuItemModel(
    isSelected: false,
    name: "Support",
    childMenuList: [
      DrawerChildMenuItemModel(
        isSelected: false,
        name: "Frequently Asked Questions",
        routePath: "faq-view-all",
        imagePath: AssetUtils.faqlogo,
      ),
    ],
  ),
  DrawerMenuItemModel(
    isSelected: false,
    childMenuList: [],
    name: "About Us",
    routePath: "/aboutUs",
  ),
  DrawerMenuItemModel(
    isSelected: false,
    childMenuList: [
      DrawerChildMenuItemModel(
          imagePath: AssetUtils.tclogo,
          name: "Terms and Conditions",
          routePath: CommonRouteString.termsAndConditions),
      DrawerChildMenuItemModel(
          imagePath: AssetUtils.privacyplogo,
          name: "Privacy Policy",
          routePath: CommonRouteString.privacyPolicy),
      DrawerChildMenuItemModel(
          imagePath: AssetUtils.legaldlogo,
          name: "Legal Disclaimer",
          routePath: CommonRouteString.legalDisclaimer),
    ],
    name: "Policies and Agreements",
    routePath: "",
  ),
  // //nps menu item
  // DrawerMenuItemModel(
  //     isSelected: false,
  //     imagePath: AssetUtils.icPolicyAndAgreement,
  //     childMenuList: [],
  //     name: "My Orders",
  //     routePath: CommonRouteString.myOrderPage),
  // //nps menu item
  // DrawerMenuItemModel(
  //     isSelected: false,
  //     imagePath: AssetUtils.icInvestDrawerIcon,
  //     childMenuList: [],
  //     name: "NPS",
  //     routePath: "/nps"),

  // //content item
  // DrawerMenuItemModel(
  //     isSelected: false,
  //     imagePath: AssetUtils.icContent,
  //     childMenuList: [],
  //     name: "Content",
  //     routePath: "/content"),

  // //services menu item
  // DrawerMenuItemModel(
  //   isSelected: false,
  //   imagePath: AssetUtils.icServicesDrawerIcon,
  //   childMenuList: [
  //     DrawerChildMenuItemModel(name: "Truepal", routePath: ''),
  //     if (VisibilityConfig.instance.showMutualFunds)
  //       DrawerChildMenuItemModel(name: "Mutual Fund", routePath: 'mf_landing')
  //   ],
  //   name: AppConstants.servicesLabel,
  // ),

  // //about us
  // DrawerMenuItemModel(
  //     isSelected: false,
  //     imagePath: AssetUtils.icAboutUs,
  //     childMenuList: [],
  //     name: "About Us",
  //     routePath: "/aboutUs"),

  // //Support
  // DrawerMenuItemModel(
  //   isSelected: false,
  //   imagePath: AssetUtils.icSupport,
  //   childMenuList: [
  //     DrawerChildMenuItemModel(name: "FAQ's", routePath: "faq-view-all"),
  //   ],
  //   name: "Support",
  // ),

  // //Policy Agreements
  // DrawerMenuItemModel(
  //   isSelected: false,
  //   imagePath: AssetUtils.icPolicyAndAgreement,
  //   childMenuList: [
  // DrawerChildMenuItemModel(
  //     name: "Terms and Conditions",
  //     routePath: CommonRouteString.termsAndConditions),
  // DrawerChildMenuItemModel(
  //     name: "Privacy Policy", routePath: CommonRouteString.privacyPolicy),
  // DrawerChildMenuItemModel(
  //     name: "Legal Disclaimer",
  //     routePath: CommonRouteString.legalDisclaimer),
  //   ],
  //   name: "Policies and Agreements",
  // ),

  //logout
  // DrawerMenuItemModel(
  //   isSelected: false,
  //   imagePath: AssetUtils.icLogout,
  //   childMenuList: [],
  //   name: "Logout",
  // ),
];

@Riverpod(keepAlive: true)
class DrawerStateNotifier extends _$DrawerStateNotifier {
  @override
  build() {
    return null;
  }

  Future<String> getVersionNumber() async {
    String version = await AppInfo.getAppVersion();
    String build = await AppInfo.getBuildNumber();
    return "$version+$build";
  }
}
