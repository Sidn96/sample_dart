import 'package:common/core/presentation/routing/global_navigation_utils.dart';
import 'package:common/features/bottom_navbar/presentation/providers/bottom_nav_bar_provider.dart';
import 'package:common/features/config/visibility_config.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:common/features/video_view/components/video_component.dart';
import 'package:flutter/material.dart';

ValueNotifier<bool> isVideoFabVisible = ValueNotifier<bool>(true);

void showVideoFab() {
  if (VisibilityConfig.instance.enableAssistVideo) {
    isVideoFabVisible.value = true;
  }
}

void hideVideoFab() {
  if (VisibilityConfig.instance.enableAssistVideo) {
    isVideoFabVisible.value = false;
  }
}

class VideoOverlayService {
  static OverlayEntry? _overlayEntry;

  // Function to show the overlay
  // static void showOverlay(BuildContext context, {VoidCallback? onExpand}) {
  //   if (VisibilityConfig.instance.enableAssistVideo) {
  //     _overlayEntry = _createOverlayEntry(context, onExpand);
  //     Overlay.of(context).insert(_overlayEntry!);
  //     hideVideoFab();
  //   }
  // }

  // Function to remove the overlay
  static void removeOverlay() {
    if (VisibilityConfig.instance.enableAssistVideo) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  static void _rebuild() {
    _overlayEntry?.markNeedsBuild();
  }

  static OverlayEntry _createOverlayEntry(
      BuildContext context, VoidCallback? onExpand) {
    return OverlayEntry(
      builder: (context) => Positioned(
        bottom: ProviderScope.containerOf(
                    GlobalNavigationUtils.rootAppNavigatorKey.currentContext!)
                .read(bottomNavBarStateNotifierProvider)
                .showNavBar
            ? 95.0
            : 20.0,
        right: 10,
        child: VideoComponent(
          onExpand: onExpand,
          onClose: () {
            removeOverlay();
            showVideoFab();
          },
          rebuild: _rebuild,
        ),
      ),
    );
  }
}
