import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:flutter/material.dart';

class AnimatedDots extends StatelessWidget {
  final Color? selectedColor;
  final Color? unSelectedColor;
  final ValueNotifier<int> valueNotifier;
  final int length;

  const AnimatedDots(
      {super.key,
      required this.length,
      required this.valueNotifier,
      this.selectedColor,
      this.unSelectedColor});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: valueNotifier,
        builder: (BuildContext context, int value, Widget? child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 6),
                child: AnimatedDot(
                  isActive: value == index,
                  selectedColor: selectedColor ?? ColorUtilsV2.hex_35354D,
                  unSelectedColor: unSelectedColor ?? ColorUtilsV2.hex_9CA3AF,
                ),
              ),
            ),
          );
        });
  }
}

class AnimatedDot extends StatelessWidget {
  final Color selectedColor;
  final Color unSelectedColor;

  const AnimatedDot(
      {super.key,
      required this.isActive,
      required this.selectedColor,
      required this.unSelectedColor});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 4,
      width: isActive ? 16 : 6,
      decoration: BoxDecoration(
        color: isActive ? selectedColor : unSelectedColor,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
