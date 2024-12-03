import 'package:common/core/presentation/widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';

class HorizontalChipsShimmer extends StatelessWidget {
  final double chipHeight;
  final double chipWidth;
  final double chipBorderRadius;
  final EdgeInsets padding;

  const HorizontalChipsShimmer({
    super.key,
    this.chipHeight = 35,
    this.chipWidth = 60,
    this.chipBorderRadius = 20,
    this.padding=const EdgeInsets.symmetric(horizontal: 10.0)
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
            4,
            (index) => Padding(
                  padding: padding,
                  child: ShimmerEffect(
                    shimmerHeight: chipHeight,
                    shimmerWidth: chipWidth,
                    borderRadius: chipBorderRadius,
                  ),
                )),
      ),
    );
  }
}
