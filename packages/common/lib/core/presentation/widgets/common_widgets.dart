import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/font_styles.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

abstract interface class CommonWidgets {

  static CommonWidgets? _singleton;

  factory CommonWidgets() {
    _singleton ??= MwebCommonWidgets();
    return _singleton!;
  }

  Widget labelAppText(String label, {Color fontColor = ColorUtils.kGreyLightColor});

  TextStyle get labelTextStyle;

  /// SizedBox with Height
  SizedBox get sizedboxH4;
  SizedBox get sizedboxH6;
  SizedBox get sizedboxH8;
  SizedBox get sizedboxH10;
  SizedBox get sizedboxH11;
  SizedBox get sizedboxH12;
  SizedBox get sizedboxH15;
  SizedBox get sizedboxH16;
  SizedBox get sizedboxH19;
  SizedBox get sizedboxH20;
  SizedBox get sizedboxH24;
  SizedBox get sizedboxH26;
  SizedBox get sizedboxH30;
  SizedBox get sizedboxH32;
  SizedBox get sizedboxH36;
  SizedBox get sizedboxH37;
  SizedBox get sizedboxH44;
  SizedBox get sizedboxH45;
  SizedBox get sizedboxH48;
  SizedBox get sizedboxH56;
  SizedBox get sizedboxH59;
  SizedBox get sizedboxH60;

  /// SizedBox with Width
  SizedBox get sizedboxW4;
  SizedBox get sizedboxW6;
  SizedBox get sizedboxW7;
  SizedBox get sizedboxW8;
  SizedBox get sizedboxW9;
  SizedBox get sizedboxW11;
  SizedBox get sizedboxW12;
  SizedBox get sizedboxW16;
  SizedBox get sizedboxW20;
  SizedBox get sizedboxW21;
  SizedBox get sizedboxW24;
  SizedBox get sizedboxW32;
  SizedBox get sizedboxW36;
  SizedBox get sizedboxW48;
  SizedBox get sizedboxW56;

  Widget loaderWidget({Color loadingColor = ColorUtilsV2.specialBackground500, Color? bgColor});

}


class MwebCommonWidgets implements CommonWidgets{

  @override
  Widget labelAppText(String label,
          {Color fontColor = ColorUtils.kGreyLightColor}) =>
      AppText(
        data: label,
        fontSize: Sizes.textSize12,
        fontColor: fontColor,
        fontWeight: FontWeight.w400,
        textAlign: TextAlign.start,
      );

  @override
  TextStyle get labelTextStyle => FontStyles.interStyle(
      fontSize: Sizes.textSize16,
      textColor: ColorUtils.kGreyLightColor,
      fontWeight: FontWeight.w400,
      height: 0.2
      );

  @override
  SizedBox get sizedboxH4 => const SizedBox(height: 4);

  @override
  SizedBox get sizedboxH6 => const SizedBox(height: 6);

  @override
  SizedBox get sizedboxH8 => const SizedBox(height: 8);

  @override
  SizedBox get sizedboxH10 => const SizedBox(height: 10);

  @override
  SizedBox get sizedboxH11 => const SizedBox(height: 11);

  @override
  SizedBox get sizedboxH12 => const SizedBox(height: 12);

  @override
  SizedBox get sizedboxH15 => const SizedBox(height: 15);

  @override
  SizedBox get sizedboxH16 => const SizedBox(height: 16);

  @override
  SizedBox get sizedboxH19 => const SizedBox(height: 19);

  @override
  SizedBox get sizedboxH20 => const SizedBox(height: 20);

  @override
  SizedBox get sizedboxH24 => const SizedBox(height: 24);

  @override
  SizedBox get sizedboxH26 => const SizedBox(height: 26);

  @override
  SizedBox get sizedboxH30 => const SizedBox(height: 30);

  @override
  SizedBox get sizedboxH32 => const SizedBox(height: 32);

  @override
  SizedBox get sizedboxH36 => const SizedBox(height: 36);

  @override
  SizedBox get sizedboxH37 => const SizedBox(height: 37);

  @override
  SizedBox get sizedboxH44 => const SizedBox(height: 44);

  @override
  SizedBox get sizedboxH45 => const SizedBox(height: 45);

  @override
  SizedBox get sizedboxH48 => const SizedBox(height: 48);

  @override
  SizedBox get sizedboxH56 => const SizedBox(height: 56);

  @override
  SizedBox get sizedboxH59 => const SizedBox(height: 59);

  @override
  SizedBox get sizedboxH60 => const SizedBox(height: 60);

  /// Widget with Width

  @override
  SizedBox get sizedboxW4 => const SizedBox(width: 4);

  @override
  SizedBox get sizedboxW6 => const SizedBox(width: 6);

  @override
  SizedBox get sizedboxW8 => const SizedBox(width: 8);

  @override
  SizedBox get sizedboxW7 => const SizedBox(width: 7);

  @override
  SizedBox get sizedboxW9 => const SizedBox(width: 9);

  @override
  SizedBox get sizedboxW11 => const SizedBox(width: 11);

  @override
  SizedBox get sizedboxW12 => const SizedBox(width: 12);

  @override
  SizedBox get sizedboxW16 => const SizedBox(width: 16);

  @override
  SizedBox get sizedboxW20 => const SizedBox(width: 20);

  @override
  SizedBox get sizedboxW24 => const SizedBox(width: 24);

  @override
  SizedBox get sizedboxW32 => const SizedBox(width: 32);

  @override
  SizedBox get sizedboxW36 => const SizedBox(width: 36);

  @override
  SizedBox get sizedboxW48 => const SizedBox(width: 48);

  @override
  SizedBox get sizedboxW56 => const SizedBox(width: 56);

  @override
  Widget loaderWidget({Color loadingColor = ColorUtilsV2.specialBackground500, Color? bgColor}) {
    return AbsorbPointer(
      child: Container(
        color : bgColor ?? Colors.grey.withOpacity(0.3),
        child:  Center(
          child: Lottie.asset(AssetUtils.loaderLottie, width: 50.0, fit: BoxFit.fitWidth),
        ),
      ),
    );
  }
  
  @override
  SizedBox get sizedboxW21 => const SizedBox(width: 21);
}