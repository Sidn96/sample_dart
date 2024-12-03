import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Retire100ImageAssetWidget extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final String? package;
  final AlignmentGeometry? alignment;
  final BoxFit? fit;
  const Retire100ImageAssetWidget({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.package,
    this.fit,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment ?? Alignment.center,
      package: package,
    );
  }
}

class Retire100ImageNetworkWidget extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final String? package;
  final AlignmentGeometry? alignment;
  final BoxFit? fit;

  const Retire100ImageNetworkWidget({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.package,
    this.fit,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      path,
      width: width ?? double.infinity,
      height: height,
      fit: fit ?? BoxFit.fill,
      alignment: alignment ?? Alignment.center,
      // package: kIsWeb ? package ?? "care100_pod" : null,
    );
  }
}

///to use svg image
class Retire100SvgImageAssetWidget extends StatelessWidget {
  final String path;
  final BoxFit boxFit;
  final Color? color;
  final double? width;
  final double? height;
  final String? package;
  final bool isNetwork;

  const Retire100SvgImageAssetWidget({
    super.key,
    required this.path,
    this.boxFit = BoxFit.contain,
    this.color,
    this.height,
    this.width,
    this.package,
    this.isNetwork = false,
  });

  @override
  Widget build(BuildContext context) {
    return isNetwork
        ? SvgPicture.network(
            path,
            color: color,
            fit: boxFit,
            width: width,
            height: height,
            // package: kIsWeb ? package ?? "care100_pod" : null,
          )
        : SvgPicture.asset(path,
            color: color,
            fit: boxFit,
            width: width,
            height: height,
            package: package
            // package: kIsWeb ? package ?? "care100_pod" : null,
            );
  }
}
