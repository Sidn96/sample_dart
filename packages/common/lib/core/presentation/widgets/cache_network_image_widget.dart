import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/widgets/retire100_images_asset_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CacheNewtorkImageWidget extends StatelessWidget {
  final String imgPath;
  final BoxFit? fit;
  const CacheNewtorkImageWidget({super.key, required this.imgPath, this.fit});

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? Retire100ImageNetworkWidget(path: imgPath)
        : CachedNetworkImage(
            imageUrl: imgPath,
            fit: fit,
            progressIndicatorBuilder: (context, url, downloadProgress) => Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.person),
                SizedBox(
                  height: 68,
                  width: 68,
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    color: ColorUtils.recommendedYellowColor,
                  ),
                ),
              ],
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          );
  }
}
