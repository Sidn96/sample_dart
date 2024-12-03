import 'dart:io';

import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/font_styles.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:common/core/presentation/widgets/app_image.dart';
import 'package:common/core/presentation/widgets/app_text_formfiled.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewPhoneNoTextField extends StatelessWidget {
  final TextEditingController? phoneNoController;
  final Function(String value)? onChanged;
  final bool? showLabelText;
  final EdgeInsets? contentPadding;
  final bool enableBottomSpacing;
  final bool enableInteractiveSelection;
  final bool isCountryFlag;
  final String? headerValue;
  final double? countryFlagHeight;
  final double? countryIndianCodeFontSize;
  final EdgeInsetsGeometry? countryIndianCodePadding;
  final InputDecoration? inputDecoration;

  const NewPhoneNoTextField(
      {Key? key,
      required this.phoneNoController,
      this.headerValue,
      this.onChanged,
      this.showLabelText,
      this.contentPadding,
      this.countryIndianCodePadding,
      this.countryFlagHeight,
      this.countryIndianCodeFontSize,
      this.enableBottomSpacing = true,
      this.enableInteractiveSelection = false,
      this.inputDecoration,
      this.isCountryFlag = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: showLabelText ?? true,
          child: AppText(
            data: headerValue ?? AppConstants.enterMobileNum,
            fontSize: Sizes.textSize12,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.start,
            height: 1,
            fontColor: ColorUtils.kGreyLightColor,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isCountryFlag)
              Padding(
                padding: const EdgeInsets.only(top: 4, right: 2),
                child: AppImage(
                  imgPath: AssetUtils.countryFlag,
                  isSvg: false,
                  height: countryFlagHeight ?? 15,
                  width: 30,
                ),
              ),
            const SizedBox(
              width: 6,
            ),
            Padding(
              padding: countryIndianCodePadding ??
                  const EdgeInsets.only(left: 2, top: 6),
              child: Text(
                AppConstants.mobileNoPrefix,
                style: FontStyles.interStyle(
                  fontSize: countryIndianCodeFontSize ?? Sizes.textSize16,
                  fontWeight: FontWeight.w700,
                  textColor: ColorUtils.black,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: AppTextFormFiled(
                labelText: (showLabelText ?? true) ? '' : AppConstants.mobileNo,
                labelStyle: FontStyles.interStyle(
                    fontSize: Sizes.textSize16,
                    textColor: ColorUtils.kGreyLightColor,
                    fontWeight: FontWeight.w700),
                controller: phoneNoController,
                inputAction: TextInputAction.done,
                inputType: !kIsWeb && Platform.isIOS
                    ? const TextInputType.numberWithOptions(
                        signed: true, decimal: true)
                    : TextInputType.number,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                contentPadding: contentPadding,
                enableInteractiveSelection: enableInteractiveSelection,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                onChanged: onChanged,
                inputBorder: InputBorder.none,
                inputDecoration: inputDecoration,
              ),
            ),
          ],
        ),
        SizedBox(
          height: enableBottomSpacing ? 8 : 0,
        ),
        Container(
          height: 1,
          color: ColorUtils.kGreyBorderColor,
        ),
        // Divider(
        //   color: ColorUtils.kGreyBorderColor,
        //   thickness: 1,
        //),
      ],
    );
  }
}
