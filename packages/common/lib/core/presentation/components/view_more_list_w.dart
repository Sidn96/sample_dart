import 'dart:math' as math;

import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:flutter/material.dart';

import '../../../features/profile/presentation/common_imports.dart';
import '../components_v2/color_utils_v2.dart';

class ViewMoreListW extends HookWidget {
  const ViewMoreListW({
    super.key,
    required this.value,
    this.expandableThreshold = 2,
  });

  /// pass the comma separated value
  final String value;

  /// pass the threshold value to expand the list
  /// it will assign the list length with this value
  final int expandableThreshold;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState<bool>(false);
    final splittedValue = value.split(",");

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 7),
            separatorBuilder: (context, index) => 10.height,
            itemCount: isExpanded.value
                ? splittedValue.length
                : math.min(splittedValue.length, expandableThreshold),
            itemBuilder: (context, index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  const Icon(Icons.circle,
                      size: 7, color: ColorUtils.darkestBlue),
                  10.width,
                  Expanded(
                    child: AppText(
                      data: (splittedValue[index]).trim(),
                      fontSize: Sizes.textSize14,
                      fontColor: ColorUtils.darkestBlue,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.start,
                      height: 1.2,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            },
          ),
          10.height,
          if (splittedValue.length > expandableThreshold)
            TextButton(
              onPressed: () {
                isExpanded.value = !isExpanded.value;
              },
              child: AppText(
                data: isExpanded.value ? "View Less" : "View More",
                fontSize: 12,
                fontColor: ColorUtilsV2.hex_2563EB,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }
}
