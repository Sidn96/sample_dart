import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:flutter/material.dart';

class DashPageIndicator extends StatelessWidget {
  final bool currentPage;
  final bool onPreviousPage;
  final Color? defaultColor;
  final Color? selectedColor;
  final double? bulletRadius;

  const DashPageIndicator(
      {Key? key,
      this.currentPage = false,
      this.onPreviousPage = false,
      this.selectedColor = ColorUtils.darkestBlue,
      this.defaultColor,
      this.bulletRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: currentPage
              ? 15
              : MediaQuery.of(context).size.width * (bulletRadius ?? 0.010),
          height: currentPage
              ? 3
              : MediaQuery.of(context).size.height * (bulletRadius ?? 0.005),
          decoration: BoxDecoration(
              color: currentPage ? selectedColor : ColorUtils.greyLight,
              // shape: BoxShape.circle ,
              borderRadius: BorderRadius.circular(5)),
        )
      ],
    );
  }
}
