import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class PlatformBuilder extends StatelessWidget {
  final Widget mWebView;
  final Widget mobileAppView;
  final Widget desktopView;

  const PlatformBuilder({super.key,
    required this.mWebView,
    required this.mobileAppView,
    required this.desktopView,
  });

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return mWebView;
    } else if (Theme.of(context).platform == TargetPlatform.android ||
        Theme.of(context).platform == TargetPlatform.iOS) {
      return mobileAppView;
    } else {
      return desktopView;
    }
  }
}
