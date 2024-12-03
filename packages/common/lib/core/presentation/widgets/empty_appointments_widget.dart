import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:flutter/material.dart';

class EmptyAppointmentsWidget extends StatelessWidget {
  final double? margin;
  final double? maxHeight;
  final String? title;
  final String? subTitle;
  const EmptyAppointmentsWidget(
      {super.key, this.margin, this.title, this.subTitle, this.maxHeight});

  @override
  Widget build(BuildContext context) => Container(
      width: double.maxFinite,
      height: maxHeight ?? 150,
      constraints: BoxConstraints(maxHeight: maxHeight ?? 150),
      margin: const EdgeInsets.fromLTRB(18.0, 15.0, 20.0, 16.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: const Color(0xFFF5F5FF),
          border: Border.all(color: const Color(0xFFE1E1FE)),
          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
                data: title ?? 'No appointments available.',
                fontColor: ColorUtils.bluishblack,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.28),
            const SizedBox(height: 5),
            AppText(
                data: subTitle ?? 'Please check again later.',
                fontColor: ColorUtils.bluishblack,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.28),
          ]));
}
