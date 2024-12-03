import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_player_notifier.g.dart';

@riverpod
class VideoPlayerMuteNotifier extends _$VideoPlayerMuteNotifier {
  //bool isVideoPlaying = true;
  bool isVideoMute = true;

  VideoPlayerMuteNotifier();

  @override
  bool build() => isVideoMute;

  void setNewMuteValue(bool mute) {
    state = mute;
  }

  muteVideo(bool value) {
    ref.watch(videoPlayerMuteNotifierProvider.notifier).setNewMuteValue(value);
  }
}

@riverpod
class VideoPlayerPlayPauseNotifier extends _$VideoPlayerPlayPauseNotifier {
  bool isVideoPlaying = true;

  VideoPlayerPlayPauseNotifier();

  @override
  bool build() => isVideoPlaying;

  void setNewPlayValue(bool play) {
    state = play;
  }

  playVideo(bool value) {
    ref
        .watch(videoPlayerPlayPauseNotifierProvider.notifier)
        .setNewPlayValue(value);
  }
}
