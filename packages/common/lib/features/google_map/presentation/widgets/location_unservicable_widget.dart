import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

class LocationUnServicableWidget extends ConsumerWidget {
  const LocationUnServicableWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          data: "Location Unserviceable",
          fontSize: 16,
          fontWeight: FontWeight.w700,
          fontColor: ColorUtils.fieldRedBorderColor,
        ),
        8.height,
        const AppText(
          data:
              "We only service areas within Thane, Mumbai, Navi Mumbai, Pune and Delhi",
          fontSize: 14,
          textAlign: TextAlign.start,
          fontWeight: FontWeight.w400,
          height: 1.3,
          fontColor: ColorUtils.midLightGrey,
        ),
      ],
    );
  }
}
