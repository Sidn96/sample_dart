import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/features/video_view/widgets/video_w.dart';
import 'package:flutter/material.dart';

class VideoComponent extends HookWidget {
  final VoidCallback? onExpand;
  final VoidCallback? onClose;
  final VoidCallback? rebuild;

  const VideoComponent({
    super.key,
    this.onExpand,
    this.onClose,
    this.rebuild,
  });

  @override
  Widget build(BuildContext context) {
    
    return Material(
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          width: 150,
          height: 275,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.transparent,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 2.0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: onExpand,
                      child: const Icon(
                        Icons.zoom_out_map_outlined,
                        size: 16,
                        color: ColorUtils.kblueMid2,
                      ),
                    ),
                    InkWell(
                      onTap: onClose,
                      child: const Icon(
                        Icons.close,
                        size: 20,
                        color: ColorUtils.kblueMid2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 240,
                child: VideoW(
                    url:
                        "https://client-static.saleassist.ai/753c6bcf-5464-4fb8-bfdf-5b106937aee4/tf_crf18.mp4",
                    width: 150,
                    height: 240),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
