import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/utils/app_images.dart';
import 'package:common/core/presentation/widgets/retire100_images_asset_widget.dart';
import 'package:common/features/config/visibility_config.dart';
import 'package:common/features/video_view/video_overlay_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VideoFab extends StatelessWidget {
  const VideoFab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return VisibilityConfig.instance.enableAssistVideo
        ? FloatingActionButton(
            backgroundColor: ColorUtils.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40))),
            onPressed: () async {
              // VideoOverlayService.showOverlay(context, onExpand: () async {
              //   VideoOverlayService.removeOverlay();
              // await context.pushNamed("/video-assist");
              //   showVideoFab();
              // });
              await context.pushNamed("/video-assist");
              showVideoFab();
            },
            child: const Retire100SvgImageAssetWidget(
              path: AppImages.mic,
              package: "common",
            ))
        : const SizedBox.shrink();
  }
}
