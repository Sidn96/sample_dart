import 'dart:io';

import 'package:common/core/presentation/components/dotted_line.dart';
import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/providers/pop_util_route.dart';
import 'package:common/core/presentation/routing/route_strings.dart';
import 'package:common/core/presentation/services/moengage_service_truefin.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/mo_engage_events_const.dart';
import 'package:common/features/login_signup/presentation/providers/notifiers/is_login_sign_status.dart';
import 'package:common/features/navigation_drawer/domain/drawer_item_model.dart';
import 'package:common/features/navigation_drawer/presentation/providers/drawer_state_provider.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

openDrawerMenuAsBottomSheet(BuildContext context,
    {Map<String, dynamic>? params}) {
  showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return DrawerBottomSheetWidget(params: params);
    },
  );
}

class DrawerBottomSheetWidget extends HookConsumerWidget {
  final Map<String, dynamic>? params;
  const DrawerBottomSheetWidget({super.key, this.params});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final screenHeight = Sizes.screenHeight;
    bool? isLogIn = ref.read(loginStatusProvider).valueOrNull;
    return ColoredBox(
      color: ColorUtilsV2.hex_7375FD,
      child: Column(
        children: [
          Container(
            height: screenHeight * 0.2,
            width: double.infinity,
            color: ColorUtilsV2.hex_7375FD,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(22),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: ColorUtilsV2.hex_4ADE80,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          child: const CircleAvatar(
                            radius: 22,
                            backgroundImage: AssetImage(AssetUtils.profile,
                                package: "common"),
                            backgroundColor: Colors.white,
                            //
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                AppTextV2(
                                  data:
                                      "Hi, ${ref.read(loginStatusProvider.notifier).getUserName()}",
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w700,
                                  fontColor: Colors.white,
                                ),
                                // if (isLogIn == true) ...[
                                //   const SizedBox(width: 14),
                                //   ExpandTapWidget(
                                //     tapPadding: const EdgeInsets.symmetric(
                                //         horizontal: 16.0, vertical: 16.0),
                                //     onTap: () {},
                                //     child: const AppImage(
                                //         height: 14,
                                //         imgPath: AssetUtils.editpen,
                                //         isSvg: true,
                                //         showColorFilter: false),
                                //   ),
                                // ],
                              ],
                            ),
                            AppTextV2(
                              data: isLogIn == true
                                  ? userInfo(ref)
                                  : "Join TrueFin and let's plan your finance ",
                              fontSize: 12.0,
                              fontColor: Colors.white,
                              fontWeight: FontWeight.w500,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 100.0,
                  child: Image.asset(AssetUtils.icTrufinDrawerAsset1),
                ),
                Positioned(
                  right: 0.0,
                  child: Image.asset(AssetUtils.icTrufinDrawerAsset2),
                ),
                Positioned(
                  top: 50,
                  right: 20,
                  child: ExpandTapWidget(
                    tapPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16.0),
                    onTap: () => context.pop(),
                    child: SizedBox(
                        height: 24.0,
                        width: 24.0,
                        child: Image.asset(AssetUtils.icDrawerCross)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14))),
              child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.only(top: 10),
                  itemBuilder: (context, index) {
                    DrawerMenuItemModel item = drawerMenuItemsList[index];
                    if (item.name == "Logout" && isLogIn == false) {
                      return const SizedBox();
                    }
                    return DrawerMenuItemWidget(
                      scrollController: scrollController,
                      item: item,
                      onParentTap: () {
                        if (item.name == "My Orders") {
                          // incase of my orders
                          context.pop();
                          context.pushNamed(CommonRouteString.myOrderPage,
                              queryParameters: item.queryParams ?? {});
                        } else if (item.name == "Logout") {
                          //incase logout
                          context.pop();
                          context.push("/logoutConfirm");
                        } else if (item.name == "About Us") {
                          context.pop();
                          context.push(item.routePath ?? "", extra: "About Us");
                        } else {
                          context.pop();
                          context.go(item.routePath ?? "");
                        }
                      },
                      onChildTap: (DrawerChildMenuItemModel childItem) {
                        if (context.canPop()) context.pop();

                        if (childItem.routePath.startsWith('/')) {
                          context.go(childItem.routePath,
                              extra: childItem.extraParams);
                        } else {
                          context.pushNamed(childItem.routePath,
                              extra: childItem.extraParams);
                        }
                      },
                    );
                  },
                  itemCount: drawerMenuItemsList.length),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: ColorUtilsV2.hex_E5E7EB)),
            ),
            child: Column(
              children: [
                DrawerMenuItemWidget(
                  scrollController: scrollController,
                  showBottomLine: false,
                  onParentTap: () {
                    MoEngageService().trackEvent(
                        eventName: MoEngageEventsConsts
                            .eventsNames.truefinloginbuttonclicked,
                        product: ProductEvent.truefin,
                        properties: {"source": params?["from"]});
                    try {
                      if (isLogIn == true) {
                        //incase logout
                        context.pop();
                        context.push("/logoutConfirm");
                      } else {
                        context.pop();
                        // context.pushNamed('/login');
                        removeAndPushReplacementNamed(context, "/login");
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  onChildTap: () {},
                  item: DrawerMenuItemModel(
                    isSelected: false,
                    imagePath: AssetUtils.icLogout,
                    childMenuList: [],
                    name: isLogIn == true ? "Logout" : "LogIn",
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String userInfo(WidgetRef ref) {
    final info = ref.read(loginStatusProvider.notifier);
    if (info.getEmail() != null) {
      return "${info.getMobileNumber()}  ●  ${info.getEmail()}";
    } else {
      return info.getMobileNumber() ?? "";
    }
  }
}

class DrawerMenuItemWidget extends HookWidget {
  final DrawerMenuItemModel item;
  final Function onParentTap;
  final Function onChildTap;
  final bool showBottomLine;
  final ScrollController scrollController;

  const DrawerMenuItemWidget(
      {super.key,
      required this.item,
      this.showBottomLine = true,
      required this.onParentTap,
      required this.scrollController,
      required this.onChildTap});

  @override
  Widget build(BuildContext context) {
    final isExpandedState = useState<bool>(false);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            if (item.childMenuList.isEmpty) {
              onParentTap();
              /*   context.pop();
              GoRouter.of(
                      GlobalNavigationUtils.rootAppNavigatorKey.currentContext!)
                  .pushNamed(item.routePath ?? "");*/

              return;
            }
            isExpandedState.value = !isExpandedState.value;
            if (item.name == "Policies and Agreements" ||
                item.name == "Support") {
              Future.delayed(const Duration(milliseconds: 500), () {
                scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 500));
              });
            }
          },
          child: Container(
            padding: EdgeInsets.only(
                top: 20.0,
                left: 23,
                right: 23.0,
                bottom: isExpandedState.value ? 0.0 : 23.0),
            decoration: BoxDecoration(
                color: isExpandedState.value
                    ? ColorUtilsV2.hex_F9FAFB
                    : Colors.white),
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  children: [
                    if (item.imagePath != null) ...[
                      SizedBox(
                          width: 30.0,
                          child: SvgPicture.asset(item.imagePath!)),
                      const SizedBox(width: 21.0),
                    ],
                    AppTextV2(
                      data: item.name,
                      fontWeight: isExpandedState.value
                          ? FontWeight.w600
                          : FontWeight.w500,
                      fontColor: ColorUtilsV2.hex_35354D,
                      fontSize: 16.0,
                    ),
                    const Spacer(),
                    if (item.childMenuList.isNotEmpty)
                      Icon(
                        isExpandedState.value
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: ColorUtilsV2.hex_4E52F8,
                      ),
                    if (item.name == "Logout")
                      Consumer(builder: (context, ref, _) {
                        return FutureBuilder(
                          future: ref
                              .read(drawerStateNotifierProvider.notifier)
                              .getVersionNumber(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return AppTextV2(
                                data: "Version ${snapshot.data ?? ""}",
                                textAlign: TextAlign.left,
                                fontWeight: FontWeight.w400,
                                fontColor: ColorUtilsV2.hex_717182,
                                fontSize: 12.0,
                              );
                            }
                            return const SizedBox();
                          },
                        );
                      })
                  ],
                ),
                if (isExpandedState.value)
                  Column(
                    children: [
                      const SizedBox(height: 23.0),
                      Container(
                        width: double.infinity,
                        height: 1.0,
                        color: ColorUtilsV2.hex_E1E1FE,
                      ),
                      for (int i = 0; i < item.childMenuList.length; i++)
                        Builder(builder: (context) {
                          final childItem = item.childMenuList[i];
                          return GestureDetector(
                            onTap: () async {
                              if (childItem.name == "Truepal") {
                                if (kIsWeb) return;
                                if (Platform.isAndroid &&
                                    await canLaunchUrl(Uri.parse(
                                        "https://play.google.com/store/apps/details?id=com.thetruepal.member"))) {
                                  await launchUrl(Uri.parse(
                                      "https://play.google.com/store/apps/details?id=com.thetruepal.member"));
                                } else if (Platform.isIOS &&
                                    await canLaunchUrl(Uri.parse(
                                        "https://apps.apple.com/in/app/truepal/id6471001802"))) {
                                  //TODO: change later to memebr
                                  await launchUrl(Uri.parse(
                                      "https://apps.apple.com/in/app/truepal/id6471001802"));
                                }
                              } else {
                                onChildTap(childItem);
                              }
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 62.0,
                                  width: double.infinity,
                                  color: Colors.transparent,
                                  child: Center(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 30.0,
                                          child: AppImage(
                                            imgPath: childItem.imagePath,
                                            isSvg: true,
                                            showColorFilter: false,
                                            package: "common",
                                          ),
                                        ),
                                        const SizedBox(width: 20.0),
                                        AppTextV2(
                                          data: childItem.name,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                          fontColor: childItem.isEnabled
                                              ? ColorUtilsV2.hex_5D5D70
                                              : ColorUtilsV2.greyMidLight,
                                          height: 32.0 / 14.0,
                                        ),
                                        const Spacer(),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 12,
                                          color: childItem.isEnabled
                                              ? ColorUtilsV2.hex_AEAEB7
                                              : ColorUtilsV2.greyMidLight,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (i !=
                                    item.childMenuList.length -
                                        1) //incase not last item
                                  const DottedLine(
                                      dashColor: ColorUtilsV2.hex_E1E1FE)
                              ],
                            ),
                          );
                        })
                    ],
                  )
              ],
            ),
          ),
        ),
        if (showBottomLine)
          Container(
              width: double.infinity,
              height: 1.0,
              color: ColorUtilsV2.hex_E5E7EB)
      ],
    );
  }
}
