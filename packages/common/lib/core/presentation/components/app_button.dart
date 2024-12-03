import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/core/presentation/styles/font_sizes.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../styles/color_utils.dart';
import '../utils/app_text.dart';

class AppButton extends StatelessWidget {
  final bool disabled;
  final bool? isBusy;
  final String label;
  final VoidCallback onPressed;
  final double buttonHeight;
  final double? buttonWidth;
  final bool wrapWidth; //This is take dynamic width of the button
  final Color borderColor;
  final double borderRadius;
  final Color buttonBgColor;
  final Color textColor;
  final TextOverflow textOverFlow;
  final TextAlign? textAlignment;
  final double? fontSize;

  //final String? serverErrorMessage;
  final String? localErrorMessage;
  final bool showLocalErrorMessage;
  final FontWeight fontWeight;
  final double? letterSpacing;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final Color circularLoaderColor;

  const AppButton({
    Key? key,
    this.disabled = false,
    this.isBusy,
    required this.label,
    required this.onPressed,
    this.buttonHeight = 40,
    this.buttonWidth,
    this.borderColor = ColorUtils.kBlueLightColor,
    this.borderRadius = 8,
    this.buttonBgColor = ColorUtils.kBlueLightColor,
    this.textColor = ColorUtils.white,
    this.textOverFlow = TextOverflow.ellipsis,
    this.textAlignment = TextAlign.start,
    this.fontSize,
    //this.serverErrorMessage,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.localErrorMessage,
    this.showLocalErrorMessage = false,
    this.fontWeight = FontWeight.w300,
    this.letterSpacing,
    this.wrapWidth = false, //Wrap the width of the button with respect to text
    this.circularLoaderColor = ColorUtils.kBlueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: [
        Visibility(
          visible: showLocalErrorMessage,
          child: AppText(
            data: localErrorMessage ?? "",
            fontSize: Sizes.defaultTextSize,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.start,
            fontColor: ColorUtils.errorColor,
          ),
        ),
        Visibility(visible: showLocalErrorMessage, child: const SizedBox(height: 10)),
        IgnorePointer(
          ignoring: isBusy ?? false,
          child: GestureDetector(
            onTap: () {
              if (!disabled) {
                onPressed.call();
              }
            },
            child: Container(
              height: buttonHeight,
              width: wrapWidth ? null : buttonWidth ?? Sizes.screenWidth() / 2,
              decoration: BoxDecoration(
                border: Border.all(
                  color: borderColor,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius),
                ),
                color: buttonBgColor,
              ),
              child: Center(
                child: isBusy ?? false
                    ? SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: circularLoaderColor,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          label,
                          textAlign: textAlignment,
                          style: TextStyle(
                              fontSize: fontSize ?? Sizes.textSize16, overflow: textOverFlow, color: textColor, letterSpacing: letterSpacing, decoration: TextDecoration.none, fontWeight: fontWeight),
                        ),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AppButtonWithIcon extends StatelessWidget {
  final Color buttonColor;
  final String buttonText;
  final String assetUrl;
  final String? assetPackageName;
  final VoidCallback onButtonClicked;
  const AppButtonWithIcon({super.key, required this.buttonColor, required this.buttonText, required this.assetUrl, this.assetPackageName, required this.onButtonClicked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonClicked,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        decoration: BoxDecoration(color: buttonColor, borderRadius: BorderRadius.circular(8.0)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(data: buttonText, fontSize: FontSizes.textSize14, fontWeight: FontWeight.w400, height: 23.0 / 14.0, fontColor: Colors.white),
            10.width,
            SvgPicture.asset(assetUrl, package: assetPackageName)
          ],
        ),
      ),
    );
  }
}
