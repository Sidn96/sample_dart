import 'package:flutter/material.dart';

import '../widgets/platform_widgets/platform_widget.dart';

//This is necessary with nested navigation to prevent transparent background of nested screens when navigating
class NestedScreenScaffold extends StatelessWidget {
  const NestedScreenScaffold({
    required this.body,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.hasAppBar = true,
    Key? key,
  }) : super(key: key);

  final Widget body;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final bool hasAppBar;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      child: PlatformWidget(
        material: (_) {
          return body;
        },
        cupertino: (_) {
          return body;
        },
      ),
    );
  }
}
