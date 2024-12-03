import 'package:chewie/chewie.dart';
import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:common/core/presentation/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../providers/chewie_provider.dart';
import '../providers/video_player_notifier.dart';

class VideoPlayerMolecule extends ConsumerWidget {
  late VideoPlayerController _videoPlayerController1;

  late AsyncValue<ChewieController>? _chewieController;

  int currPlayIndex = 0;
  bool? isPlayerMuteValue;
  bool? isVideoPlaying;

  final String videoUrlPath;

  VideoPlayerMolecule({
    Key? key,
    required this.videoUrlPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return videoPlayer(context, ref, videoUrlPath);
  }

  Widget customPlayerControls(
    WidgetRef widgetRef,
    VideoPlayerMuteNotifier videoPlayerMuteNotifier,
    VideoPlayerPlayPauseNotifier videoPlayerPlayPauseNotifier,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (!isVideoPlaying!) {
                videoPlayerPlayPauseNotifier.playVideo(true);
                _videoPlayerController1.play();
              } else {
                videoPlayerPlayPauseNotifier.playVideo(false);
                _videoPlayerController1.pause();
              }
            },
            child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: ColorUtils.kBlueColor),
                    shape: BoxShape.circle,
                    color: ColorUtils.white),
                child: AppImage(
                  imgPath: isVideoPlaying!
                      ? AssetUtils.pauseIcon
                      : AssetUtils.playIcon,
                  height: 14,
                  isSvg: true,
                )),
          ),
          GestureDetector(
            onTap: () {
              if (isPlayerMuteValue!) {
                videoPlayerMuteNotifier.muteVideo(false);
                _videoPlayerController1.setVolume(5);
              } else {
                videoPlayerMuteNotifier.muteVideo(true);
                _videoPlayerController1.setVolume(0);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: ColorUtils.kBlueColor),
                  shape: BoxShape.circle,
                  color: ColorUtils.white),
              child: AppImage(
                imgPath: isPlayerMuteValue!
                    ? AssetUtils.muteIcon
                    : AssetUtils.unMuteIcon,
                height: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget videoPlayer(BuildContext context, WidgetRef ref, String videoUrl) {
    _videoPlayerController1 =
        ref.watch(getVideoPlayerControllerProvider(videoUrl));
    _chewieController = ref.watch(getChewieControllerProvider(videoUrl));

    final isPlayerMuteWatch =
        ref.watch(videoPlayerMuteNotifierProvider.notifier);
    isPlayerMuteValue = ref.watch(videoPlayerMuteNotifierProvider);

    final isVideoPlayingWatch =
        ref.watch(videoPlayerPlayPauseNotifierProvider.notifier);
    isVideoPlaying = ref.watch(videoPlayerPlayPauseNotifierProvider);

    return Stack(alignment: Alignment.bottomCenter, children: [
      _chewieController!.value != null &&
              _videoPlayerController1.value.isInitialized
          ? SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Chewie(
                controller: _chewieController!.value!,
              ),
            )
          :  const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                AppText(
                  data: 'Loading...',
                  fontSize: Sizes.textSize12,
                ),
              ],
            ),
      customPlayerControls(ref, isPlayerMuteWatch, isVideoPlayingWatch),
    ]);
  }
}
