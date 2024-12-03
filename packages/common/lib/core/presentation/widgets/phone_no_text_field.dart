
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../styles/app_assets.dart';
import '../styles/color_utils.dart';
import '../styles/font_styles.dart';
import '../styles/sizes.dart';
import '../utils/app_string_constants.dart';
import '../utils/app_text.dart';
import 'app_image.dart';
import 'app_text_formfiled.dart';

class PhoneNoTextField extends StatelessWidget {
  final TextEditingController? phoneNoController;
  final Function(String value)? onChanged;
  final bool? showLabelText;
  final EdgeInsets? contentPadding;
  final bool enableBottomSpacing;
  final String? whatsAppNum;
  final Widget? postfixWidget;

  const PhoneNoTextField({
    Key? key,
    required this.phoneNoController,
    this.whatsAppNum,
    this.onChanged,
    this.showLabelText,
    this.contentPadding,
    this.postfixWidget,
    this.enableBottomSpacing = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: showLabelText ?? true,
          child: AppText(
            data: whatsAppNum ?? AppConstants.mobileNo,
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
            const Padding(
              padding: EdgeInsets.only(top: 4, right: 2),
              child: AppImage(
                imgPath: AssetUtils.countryFlag,
                isSvg: false,
                height: 15,
                width: 30,
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 2, top: 6),
              child: AppText(
                data: AppConstants.mobileNoPrefix,
                fontSize: Sizes.textSize16,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.start,
                fontColor: ColorUtils.black,
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
                inputType: TextInputType.phone,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                contentPadding: contentPadding,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                onChanged: onChanged,
                inputBorder: InputBorder.none,
                suffixIcon: postfixWidget,
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
