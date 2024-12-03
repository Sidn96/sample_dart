import 'package:chewie/chewie.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:video_player/video_player.dart';

part 'chewie_provider.g.dart';

@riverpod
VideoPlayerController getVideoPlayerController(
    GetVideoPlayerControllerRef ref,String videoUrl) {
  return VideoPlayerController.asset(videoUrl,package: 'common');
}

@riverpod
FutureOr<ChewieController> getChewieController(
    GetChewieControllerRef ref,String videoUrl) async {
  final videoPlayerController = ref.read(getVideoPlayerControllerProvider(videoUrl));
  await videoPlayerController.initialize();
  videoPlayerController.setVolume(0);
  return ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
      showControls: false);
}
