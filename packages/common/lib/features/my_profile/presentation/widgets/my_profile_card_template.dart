import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:flutter/material.dart';

class MyProfileCardTemplate extends StatelessWidget {
  const MyProfileCardTemplate({super.key, required this.widget});

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: ColorUtils.kGreyBorderColor),
            borderRadius: const BorderRadius.all(Radius.circular(20.0))),
        child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 18.0),
            child: widget),
      ),
    );
  }
}
