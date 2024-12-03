import 'package:common/core/presentation/components_v2/components_v2.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AppSnackBar {

  static AnimationController? _animationController;

  static void show({
    required BuildContext context,
    required String message,
    Color fontColor = ColorUtilsV2.hex_F9FAFB,
    Color bgColor = ColorUtilsV2.hex_2A2A3D,
  }) {
    showTopSnackBar(
      Overlay.of(context),
      Material(
        color: Colors.transparent,
        child: Container(
          decoration: ShapeDecoration(
              color: bgColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40))),
          margin: const EdgeInsets.only(left: 18, right: 18),
          padding: const EdgeInsets.all(14),
          child: AppTextV2(
            data: message,
            fontSize: 12,
            fontColor: fontColor,
          ),
        ),
      ),
    );
  }

  static void mfSnackBar(
      {required BuildContext context,
      required String message,
      required bool isPositiveCase, bool showIcon = true}) {
    showTopSnackBar(
      Overlay.of(context),
      snackBarPosition: SnackBarPosition.bottom,
      Column(
        children: [
          Container(
            width: Sizes.screenWidth(),
            decoration: ShapeDecoration(
                color: isPositiveCase
                    ? ColorUtilsV2.hex_DCFCE7
                    : ColorUtilsV2.hex_FECACA,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                        color: isPositiveCase
                            ? ColorUtilsV2.specialSuccess300
                            : ColorUtilsV2.specialDestructive300))),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              children: [
                showIcon
                    ? Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isPositiveCase
                                ? ColorUtilsV2.hex_BBF7D0
                                : ColorUtilsV2.specialDestructive300
                                    .withOpacity(.6)),
                        child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isPositiveCase
                                    ? ColorUtilsV2.specialSuccess300
                                    : ColorUtilsV2.specialDestructive300),
                            child: SvgPicture.asset(AppImages.icCartIcon,
                                height: 20, package: 'common')),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(width: 8),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: AppTextV2(
                      textAlign: TextAlign.start,
                      data: message,
                      fontSize: 14,
                      fontColor: ColorUtilsV2.specialNeutral700,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  package: 'common',
                  AppImages.icCloseRounded,
                  height: 20,
                )
              ],
            ),
          ),
          const SizedBox(height: 60)
        ],
      ),
      onAnimationControllerInit: (controller) =>
          _animationController = controller,
    );
  }

//@TODO test once
  static void showError({
    required BuildContext context,
    required String message,
    Color fontColor = ColorUtilsV2.hex_FFFFFF,
    Color bgColor = ColorUtilsV2.hex_F87171,
  }) {
    show(
        context: context,
        message: message,
        fontColor: fontColor,
        bgColor: bgColor);
  }

  static void hide(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    try{
      if(_animationController != null && !_animationController!.isDismissed) {
        _animationController!.reverse();
      }
    } catch(e){
      debugPrint("AppSnackbar hide error: ${e.toString()}");
    }
  }
}
