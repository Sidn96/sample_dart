import 'package:flutter/material.dart';

import '../styles/color_utils.dart';

class AppBottomSheet extends StatelessWidget {
  final Widget childWidget;
  final double topLeftRadius;
  final double topRightRadius;
  final Color? backgroundColor;

  const AppBottomSheet({
    Key? key,
    required this.childWidget,
    this.topRightRadius = 24.0,
    this.topLeftRadius = 24.0,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? ColorUtils.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeftRadius),
          topRight: Radius.circular(topRightRadius),
        ),
      ),
      child: SafeArea(
        bottom: true,
          child: childWidget),
    );
  }
}
