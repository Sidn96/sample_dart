import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  final double shimmerHeight;
  final double shimmerWidth;
  final double borderRadius;

  const ShimmerEffect({
    Key? key,
    this.shimmerHeight = 100,
    this.shimmerWidth = 100,
    this.borderRadius = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: shimmerHeight,
        width: shimmerWidth,
        decoration: BoxDecoration(
          color: Colors.grey[500],
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
