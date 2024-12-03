import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/font_styles.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:common/core/presentation/widgets/app_text_formfiled.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../styles/app_assets.dart';
import '../utils/riverpod_framework.dart';
import '../widgets/app_image.dart';

final countryCodeProvider = StateProvider<String?>((ref) => null);

class PhoneNoTextFieldCommon extends ConsumerWidget {
  final TextEditingController? phoneNoController;
  final Function(String value)? onChanged;
  final bool? showLabelText;
  final EdgeInsets? contentPadding;
  final bool enableBottomSpacing;
  final String? numberHeaderName;
  final Widget? sufixWidget;
  final EdgeInsetsGeometry? padding;
  final bool isIndiaFlag;
  final Widget? prefixIcon;

  const PhoneNoTextFieldCommon({
    Key? key,
    required this.phoneNoController,
    this.isIndiaFlag = false,
    this.numberHeaderName,
    this.onChanged,
    this.showLabelText,
    this.contentPadding,
    this.sufixWidget,
    this.padding,
    this.prefixIcon,
    this.enableBottomSpacing = true,

  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> coutryfilters = [
      "+91",
      "+44",
      "+1",
      "+977",
      "+975",
      "+213",
      "+973",
      "+253",
      "+20",
      "+964",
      "+962",
      "+965",
      "+961",
      "+218",
      "+222",
      "+212",
      "+968",
      "+970",
      "+966",
      "+252",
      "+249",
      "+216",
      "+971",
      "+967",
      "+98"
    ];

    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 19.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: showLabelText ?? true,
            child: AppText(
              data: numberHeaderName ?? AppConstants.mobileNo,
              fontSize: Sizes.textSize12,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.start,
              //height: 1,
              fontColor: ColorUtils.kGreyLightColor,
            ),
          ),
          AppTextFormFiled(
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
            suffixIcon: sufixWidget,
            // prefixText: prefixText,
            prefixIcon: prefixIcon ??
                Stack(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    isIndiaFlag
                        ?  const Padding(
                            padding: EdgeInsets.only(top: 14.0, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 5.8, right: 3),
                                  child: AppImage(
                                    imgPath: AssetUtils.countryFlag,
                                    isSvg: false,
                                    height: 15,
                                    width: 30,
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 2, top: 9.8),
                                  child: AppText(
                                    data: AppConstants.mobileNoPrefix,
                                    fontSize: Sizes.textSize16,
                                    fontWeight: FontWeight.w700,
                                    textAlign: TextAlign.start,
                                    fontColor: ColorUtils.black,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Row(
                            children: [
                              Theme(
                                data: ThemeData(
                                    textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                      padding: const EdgeInsets.only(
                                        top: 5,
                                      ),
                                      minimumSize: const Size(50, 30),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      alignment: Alignment.centerLeft),
                                )),
                                child: CountryCodePicker(
                                  showDropDownButton: true,
                                  initialSelection: "+91",
                                  textStyle: FontStyles.interStyle(
                                    fontSize: Sizes.textSize16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  countryFilter: coutryfilters,
                                  onChanged: (country) {
                                    ref
                                        .read(countryCodeProvider.notifier)
                                        .state = country.dialCode!;
                                  },
                                  favorite: const [
                                    "+91",
                                  ],
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 1, // Set the width of the divider
                                color: ColorUtils.kGreyBorderColor,
                                margin: const EdgeInsets.only(
                                    right: 10,
                                    top:
                                        7), // Add some spacing between the prefix icon and the divider
                              )
                            ],
                          ),
                  ],
                ),
              ],
                ),
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
