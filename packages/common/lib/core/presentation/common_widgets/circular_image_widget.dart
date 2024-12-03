import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularImageW extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final String imagePath;
  final Widget Function(BuildContext, String, DownloadProgress)?
      progressIndicatorBuilder;
  final Widget Function(BuildContext, String, Object)? errorWidget;

  const CircularImageW({
    Key? key,
    this.width,
    this.height,
    this.radius,
    required this.imagePath,
    this.progressIndicatorBuilder,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: imagePath,
        width: width ?? 80,
        height: height ?? 80,
        fit: BoxFit.fill,
        progressIndicatorBuilder: progressIndicatorBuilder,
        errorWidget: errorWidget,
      ),
    );
  }
}
