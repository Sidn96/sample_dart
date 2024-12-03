import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageUtil {
  ImageUtil._();

  static Widget load(
    String name, {
    String? package,
    final bool networkImg = false,
    final Color color = Colors.transparent,
    final double? width,
    final double? height,
    final BoxFit? fit,
    final Widget? widget,
    final String? semanticsLabel,
  }) {
    if (widget != null) {
      return widget;
    }

    if (name.isEmpty) {
      throw AssertionError("Asset Name is empty");
    }

    var isSvgAsset = name.isNotEmpty && name.split('.').last == 'svg';

    if (networkImg) {
      var headers = const {
        'Cache-Control': 'no-cache',
        'Pragma': 'no-cache',
      };

      var loadingWidget = Container(
          padding: const EdgeInsets.all(30.0),
          child: const CircularProgressIndicator());

      return (isSvgAsset)
          ? SvgPicture.network(
              name,
              width: width,
              matchTextDirection: true,
              height: height,
              fit: fit ?? BoxFit.contain,
              semanticsLabel: semanticsLabel,
              colorFilter:
                  const ColorFilter.mode(Colors.black12, BlendMode.srcIn),
              placeholderBuilder: (BuildContext context) => loadingWidget,
              headers: headers,
            )
          : Image.network(name,
              width: width,
              height: height,
              semanticLabel: semanticsLabel,
              fit: fit ?? BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) =>
                  loadingWidget,
              headers: headers);
    } else {
      return (isSvgAsset) //.extension(name) == '.svg')
          ? SvgPicture.asset(
              name,
              width: width,
              package: package ?? 'common',
              matchTextDirection: true,
              height: height,
              semanticsLabel: semanticsLabel,
              fit: fit ?? BoxFit.contain,
              colorFilter: ColorFilter.mode(color, BlendMode.srcATop),
            )
          : Image.asset(
              name,
              width: width,
              package: package ?? 'common',
              height: height,
              semanticLabel: semanticsLabel,
              fit: fit ?? BoxFit.contain,
            );
    }
  }
}
