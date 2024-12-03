import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:flutter/material.dart';

class YesNoButtonWidget extends StatelessWidget {
  /// if the isPositiveFlow flag is true
  /// then positive button will be on right side
  final bool isPositiveFlow;
  final String? positiveLabel;
  final String? negativeLabel;
  final Function()? onPositiveClick;
  final Function()? onNegativeClick;
  const YesNoButtonWidget(
      {super.key,
      this.isPositiveFlow = true,
      this.positiveLabel,
      this.negativeLabel,
      this.onPositiveClick,
      this.onNegativeClick});

  @override
  Widget build(BuildContext context) => isPositiveFlow
      ? Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _YesNoButtonItem(
              label: negativeLabel ?? 'No',
              fontColor: ColorUtils.bluishblack,
              backgroundColor: Colors.transparent,
              onClick: onNegativeClick),
          _YesNoButtonItem(
              label: positiveLabel ?? 'Yes',
              onClick: onPositiveClick,
              borderColor: ColorUtils.yellow),
        ])
      : Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _YesNoButtonItem(
              label: positiveLabel ?? 'Yes',
              fontColor: ColorUtils.bluishblack,
              backgroundColor: Colors.transparent,
              onClick: onPositiveClick),
          _YesNoButtonItem(
            label: negativeLabel ?? 'No',
            onClick: onNegativeClick,
            borderColor: ColorUtils.yellow,
            fontColor: ColorUtils.bluishblack,
          )
        ]);
}

class _YesNoButtonItem extends StatelessWidget {
  final String label;
  final Color? fontColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final Function()? onClick;
  const _YesNoButtonItem(
      {super.key,
      required this.label,
      this.fontColor,
      this.backgroundColor,
      this.borderColor,
      this.onClick});

  @override
  Widget build(BuildContext context) => OutlinedButton(
      onPressed: onClick,
      style: OutlinedButton.styleFrom(
          minimumSize: Size(MediaQuery.of(context).size.width / 2.3, 46),
          maximumSize: Size(MediaQuery.of(context).size.width / 2.3, 46),
          backgroundColor: backgroundColor ?? ColorUtils.yellow,
          side: BorderSide(color: borderColor ?? ColorUtils.bluishblack)),
      child: AppText(
          data: label,
          textAlign: TextAlign.center,
          fontColor: fontColor ?? ColorUtils.bluishblack,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.24));
}
