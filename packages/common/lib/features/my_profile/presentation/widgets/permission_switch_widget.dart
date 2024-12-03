import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:flutter/material.dart';

class PermissionSwitchWidget extends HookWidget {
  final animationDuration = const Duration(milliseconds: 200);
  final Function(bool value) onSwitchPressed;
  final bool isSwitchPressedValue;

  const PermissionSwitchWidget({
    Key? key,
    required this.onSwitchPressed,
    this.isSwitchPressedValue = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSwitchPressed = useState<bool>(isSwitchPressedValue);

    return GestureDetector(
      onTap: () {
        isSwitchPressed.value = !isSwitchPressed.value;
        onSwitchPressed(isSwitchPressed.value);
      },
      child: Container(
        height: Sizes.screenHeight * 0.04,
        width: Sizes.screenWidth() * 0.22,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorUtils.lightGrayColor,
        ),
        child: Stack(
          children: [
            Align(
              alignment: isSwitchPressed.value
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: FittedBox(
                  child: AppText(
                    data: isSwitchPressed.value ? "No" : "Yes",
                    fontSize: Sizes.textSize12,
                    fontColor: ColorUtils.blackBluish,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            AnimatedAlign(
              duration: animationDuration,
              alignment: isSwitchPressed.value
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Container(
                width: Sizes.screenWidth() * 0.12,
                decoration: BoxDecoration(
                  color: isSwitchPressed.value
                      ? ColorUtils.kGreenLightColor
                      : ColorUtils.errorLightColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: AppText(
                    data: isSwitchPressed.value ? "Yes" : "No",
                    fontSize: Sizes.textSize12,
                    fontColor: ColorUtils.blackBluish,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
