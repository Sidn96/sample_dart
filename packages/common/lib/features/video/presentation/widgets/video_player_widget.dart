import 'dart:developer';

import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart' as webPkg;

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late YoutubePlayerController controller;
  late webPkg.YoutubePlayerController webController;
  bool showAppBar = true;

  @override
  void initState() {
    controller = YoutubePlayerController(
        enableSeek: true,
        initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl) ?? "",
        flags: const YoutubePlayerFlags(autoPlay: false, mute: false));
    webController = webPkg.YoutubePlayerController.fromVideoId(
      videoId: YoutubePlayer.convertUrlToId(widget.videoUrl) ?? "",
      autoPlay: false,
      params: const webPkg.YoutubePlayerParams(showFullscreenButton: false,showControls: true),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      //for web
      return webPkg.YoutubePlayerScaffold(
        aspectRatio: 16/9,
        builder: (context, player) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                      onTap: () => context.pop(),
                      child: Icon(Icons.close, color: Colors.white)),
                ),
                const SizedBox(height: 6.0),
                player,
              ],
            ),
          );
        },
        controller: webController,
      );
    }
    //for mobile
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        onReady: () {
          controller.play();
        },
        showVideoProgressIndicator: true,
        controller: controller,
      ),
      builder: (context, player) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(Icons.close, color: Colors.white)),
              ),
              const SizedBox(height: 6.0),
              player,
            ],
          ),
        );
      },
    );
  }
}
