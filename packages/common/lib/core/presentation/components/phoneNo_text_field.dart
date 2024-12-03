import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/font_styles.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:common/core/presentation/widgets/app_image.dart';
import 'package:common/core/presentation/widgets/app_text_formfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNoTextField extends StatelessWidget {
  final TextEditingController? phoneNoController;
  final Function(String value)? onChanged;
  final bool? showLabelText;
  final EdgeInsets? contentPadding;
  final bool enableBottomSpacing;
  final String? numberHeaderName;
  final Widget? sufixWidget;
  const PhoneNoTextField({
    Key? key,
    required this.phoneNoController,
    this.numberHeaderName,
    this.onChanged,
    this.showLabelText,
    this.contentPadding,
    this.sufixWidget,
    this.enableBottomSpacing = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: showLabelText ?? true,
            child:  Padding(
              padding: const EdgeInsets.only(top:10),
              child: AppText(
                data: numberHeaderName ?? AppConstants.mobileNo,
                fontSize: Sizes.textSize12,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.start,
                height: 1,
                fontColor: ColorUtils.kGreyLightColor,
              ),
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
                  labelText:
                      (showLabelText ?? true) ? '' : AppConstants.mobileNo,
                  labelStyle: FontStyles.interStyle(
                      fontSize: Sizes.textSize16,
                      textColor: ColorUtils.kGreyLightColor,
                      fontWeight: FontWeight.w700),
                  controller: phoneNoController,
                  inputType: TextInputType.number,
                  inputAction: TextInputAction.done,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  contentPadding: contentPadding,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  onChanged: onChanged,
                  inputBorder: InputBorder.none,
                  suffixIcon: sufixWidget,
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
      ),
    );
  }
}
