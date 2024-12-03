import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBoxWidget extends StatelessWidget {
  const ShimmerBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: ColorUtilsV2.hex_E0E0E0,
                highlightColor: ColorUtilsV2.hex_F5F5FF,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: ColorUtilsV2.hex_E0E0E0,
                    highlightColor: ColorUtilsV2.hex_F5F5FF,
                    child: Container(
                      height: 20,
                      width: 160,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Shimmer.fromColors(
                    baseColor: ColorUtilsV2.hex_E0E0E0,
                    highlightColor: ColorUtilsV2.hex_F5F5FF,
                    child: Container(
                      height: 20,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: ColorUtilsV2.hex_E0E0E0,
                highlightColor: ColorUtilsV2.hex_F5F5FF,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: ColorUtilsV2.hex_E0E0E0,
                    highlightColor: ColorUtilsV2.hex_F5F5FF,
                    child: Container(
                      height: 20,
                      width: 160,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Shimmer.fromColors(
                    baseColor: ColorUtilsV2.hex_E0E0E0,
                    highlightColor: ColorUtilsV2.hex_F5F5FF,
                    child: Container(
                      height: 20,
                      width: 170,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Shimmer.fromColors(
            baseColor: ColorUtilsV2.hex_E0E0E0,
            highlightColor: ColorUtilsV2.hex_F5F5FF,
            child: Container(
              height: 20,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 10),
          Shimmer.fromColors(
            baseColor: ColorUtilsV2.hex_E0E0E0,
            highlightColor: ColorUtilsV2.hex_F5F5FF,
            child: Container(
              height: 20,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}
