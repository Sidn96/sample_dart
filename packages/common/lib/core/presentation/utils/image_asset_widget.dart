import 'package:flutter/widgets.dart';

class ImageAssetWidget extends StatelessWidget {
  final String path;
  final double? height;
  const ImageAssetWidget({super.key, required this.path, this.height});

  @override
  Widget build(BuildContext context) {
    return Image.asset(path, package: "common",height: height,);
  }
}
