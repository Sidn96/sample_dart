import 'package:common/core/presentation/routing/route_strings.dart';
import 'package:common/core/presentation/services/moengage_service_truefin.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/mo_engage_events_const.dart';
import 'package:common/features/bottom_navbar/presentation/providers/bottom_nav_bar_provider.dart';
import 'package:common/features/bottom_navbar/presentation/widgets/bottom_navbar_widget.dart';
import 'package:common/features/video_view/video_overlay_service.dart';
import 'package:common/features/video_view/widgets/video_fab.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/utils/riverpod_framework.dart';

GlobalKey<ScaffoldState> drawerScaffoldKey = GlobalKey();

class BottomNavBarWrapper extends ConsumerWidget {
  final Widget child;

  const BottomNavBarWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bottomNavBarStateNotifierProvider);
    // if (kIsWeb) return child;
    return Material(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Scaffold(
              //resizeToAvoidBottomInset: false, //commented to resolve bottom sheet issue in gmail sync
              body: Builder(
                key: const Key("bottom_nav_child"),
                builder: (context) {
                  return child;
                },
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            bottom: state.showNavBar ? 0.0 : -80.0,
            child: const BottomNavBarWidget(),
          ),
          Positioned(
              bottom: 40.0,
              child: GestureDetector(
                onTap: () {
                  MoEngageService().trackEvent(
                      eventName: MoEngageEventsConsts
                          .eventsNames.truefinHomepageCtaClicked,
                      product: ProductEvent.truefin,
                      properties: {"selection": "oneview dashboard"});
                  // context.go("/dashboard/false");
                  context.go(CommonRouteString.oneviewScreen);
                },
                child: AnimatedContainer(
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 300),
                  width: state.showNavBar ? icLogoWidgetSize : 0.0,
                  height: state.showNavBar ? icLogoWidgetSize : 0.0,
                  child: const IcNavLogoWidget(),
                ),
              )),
          ValueListenableBuilder(
              valueListenable: isVideoFabVisible,
              builder: (context, val, __) {
                return val
                    ? Positioned(
                        right: 20,
                        bottom: ref
                                .read(bottomNavBarStateNotifierProvider)
                                .showNavBar
                            ? 120
                            : 20,
                        child: const VideoFab())
                    : const SizedBox.shrink();
              })
        ],
      ),
    );
  }
}
