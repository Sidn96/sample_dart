import 'package:flutter/material.dart';

class PlatformBasedWidget extends StatelessWidget {
  final Widget? android;
  final Widget? ios;
  final Widget? other;
  const PlatformBasedWidget({super.key, this.android, this.ios, this.other});

  @override
  Widget build(BuildContext context) {
    // this widgets also use for mweb to specific Platform
    final platform = Theme.of(context).platform;
    if (platform == TargetPlatform.android && android != null) {
      return android!;
    } else if (platform == TargetPlatform.iOS && ios != null) {
      return ios!;
    } else {
      return other ?? const SizedBox.shrink();
    }
  }
}
