import 'package:chewie/chewie.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

class VideoW extends HookWidget {
  final String url;
  final double width;
  final double height;
  final bool? showBackButton;

  const VideoW(
      {super.key,
      required this.url,
      required this.width,
      required this.height,
      this.showBackButton});

  @override
  Widget build(BuildContext context) {
    final videoPlayerController = useMemoized(
      () => VideoPlayerController.networkUrl(Uri.parse(url)),
      [url],
    );

    final chewieController = useState<ChewieController?>(null);
    final volume = useState<double>(0.0); // Default volume is 1.0 (max)
    final screenSize =
        View.of(context).physicalSize / View.of(context).devicePixelRatio;

    // Use effect for asynchronous initialization
    useEffect(() {
      // Initialize video player controller
      videoPlayerController.initialize().then((_) {
        chewieController.value = ChewieController(
            videoPlayerController: videoPlayerController,
            autoPlay: true,
            looping: true,
            showControls: false,
            aspectRatio: width != 150 ? screenSize.aspectRatio : 0.61);
      });

      // Cleanup on widget dispose
      return () {
        videoPlayerController.dispose();
        chewieController.value?.dispose();
      };
    }, [videoPlayerController]);

    return Container(
      color: chewieController.value != null
          ? ColorUtils.transparent
          : ColorUtils.white,
      width: width,
      height: height,
      child: chewieController.value != null
          ? Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(width != 150 ? 0.0 : 12.0),
                      bottomRight: Radius.circular(width != 150 ? 0.0 : 12.0)),
                  child: OverflowBox(
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.cover, // Ensure video covers area
                      child: SizedBox(
                        width: width,
                        height: height,
                        child: Chewie(controller: chewieController.value!),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: width != 150 ? 10 : 0,
                  top: width != 150 ? 30 : 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 12.0),
                    child: Icon(
                      volume.value != 1
                          ? Icons.volume_off
                          : Icons.volume_up_outlined,
                      size: 25,
                      color: ColorUtils.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (volume.value == 1) {
                      volume.value = 0.0;
                    } else {
                      volume.value = 1.0;
                    }
                    videoPlayerController.setVolume(volume.value);
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: height,
                    width: width,
                  ),
                ),
                if (showBackButton ?? false)
                  Positioned(
                      left: 10,
                      top: 30,
                      child: IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                          color: ColorUtils.white,
                        ),
                      )),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
