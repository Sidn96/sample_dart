import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:flutter/material.dart';

import '../components_v2/color_utils_v2.dart';

class CacheNetworkDocumentWidget extends StatefulWidget {
  final String imgPath;
  final BoxFit? fit;
  final double? height,width;
  const CacheNetworkDocumentWidget({super.key, required this.imgPath, this.fit,this.height=68,this.width=68});

  @override
  State<CacheNetworkDocumentWidget> createState() => _CacheNetworkDocumentWidgetState();
}

class _CacheNetworkDocumentWidgetState extends State<CacheNetworkDocumentWidget> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.imgPath,
      fit: widget.fit,
      height: widget.height,
      progressIndicatorBuilder: (context, url, downloadProgress) {
        return Center(child: SizedBox(
          height: 15,width: 15,
          child: CircularProgressIndicator(
            value: downloadProgress.progress,
            color: ColorUtils.fadedJade,
          ),
        ));

      },
      errorWidget: (context, url, error) {
        return const Icon(Icons.error,color: ColorUtilsV2.specialDestructive400);
      },
    );
  }
}
