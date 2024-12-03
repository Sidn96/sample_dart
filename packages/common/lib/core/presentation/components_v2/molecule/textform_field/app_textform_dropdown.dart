import 'package:common/core/presentation/components_v2/molecule/textform_field/textform_helper.dart';
import 'package:common/core/presentation/styles/font_sizes.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app_text_v2.dart';
import '../../color_utils_v2.dart';

class AppTextFormDropdown extends HookWidget {
  final TextEditingController? controller;
  final Function()? onInputTap;
  final TextInputAction? inputAction;
  final TextInputType? inputType;
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final bool autoFocus;
  final AutovalidateMode? autoValidateMode;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final bool readOnly;
  final int maxLines;
  final int? maxLength;
  final bool obscureText;
  final String obscuringCharacter;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final bool busy;
  final double? fontSize;
  final double? labelFontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final EdgeInsets? contentPadding;
  final Color? hintColor;
  final bool enabled;
  final bool? showCursor;
  final InputDecoration? inputDecoration;
  final String? prefixText;
  final TextStyle? prefixTextStyle;
  final TextStyle? textStyle;
  final double? textLineHeight;
  final List<dynamic> dataModel;
  final Function(dynamic newVal) onChangedDropDown;
  final String dropDownSelectedVal;

  const AppTextFormDropdown(
      {super.key,
        this.controller, this.onInputTap, this.inputAction, this.inputType, this.labelText, this.hintText, this.initialValue,
        this.autoFocus = false, this.autoValidateMode = AutovalidateMode.onUserInteraction, this.validator, this.onChanged,
        this.readOnly = false, this.maxLines = 1, this.maxLength, this.obscureText = false, this.obscuringCharacter = AppConstants.symbolStar,
        this.suffixIcon, this.prefixIcon, this.textAlign = TextAlign.start, this.inputFormatters, this.busy = false,
        this.fontSize, this.labelFontSize, this.fontWeight, this.textColor, this.contentPadding = const EdgeInsets.fromLTRB(25, 22, 25, 22),
        this.hintColor, this.enabled = true, this.showCursor, this.inputDecoration, this.prefixText, this.prefixTextStyle, this.textStyle,
        this.textLineHeight, required this.dataModel, required this.onChangedDropDown, required this.dropDownSelectedVal});


  @override
  Widget build(BuildContext context) {
    final errorText = useState<String?>(null);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
          height: 56,
          padding: const EdgeInsets.only(left: 6),
          decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: ColorUtils.kGreyBorderColor,),
            borderRadius: const BorderRadius.all(Radius.circular(6))
          ),
          child: Row(
            children: [

              Expanded(
                flex: 60,
                child: TextFormField(
                  controller: controller,
                  textAlign: textAlign,
                  style: textStyle ?? TextFormHelper.defaultTextStyle(errorText: errorText.value, textLineHeight: textLineHeight),
                  cursorHeight: 25,
                  initialValue: initialValue,
                  inputFormatters: inputFormatters,
                  textInputAction: inputAction,
                  autovalidateMode: autoValidateMode,
                  maxLines: maxLines,
                  minLines: 1,
                  maxLength: maxLength,
                  readOnly: readOnly,
                  obscureText: obscureText,
                  obscuringCharacter: obscuringCharacter,
                  autofocus: autoFocus,
                  enabled: enabled,
                  showCursor: showCursor,
                  onChanged: (value){
                    var error = validator?.call(value);
                    if(error != null && error.isNotEmpty){
                      errorText.value = error;
                    }else{
                      errorText.value = null;
                    }
                    onChanged?.call(value);
                  },
                  onTap: () => onInputTap?.call(),
                  decoration: inputDecoration ??
                      InputDecoration(
                        alignLabelWithHint: true,
                        contentPadding: contentPadding,
                        prefixIcon: prefixIcon,
                        suffixIcon: suffixIcon,
                        prefixText: prefixText,
                        prefixStyle: prefixTextStyle,
                        hintStyle: TextFormHelper.hintStyle(),
                        labelText: labelText,
                        labelStyle: TextFormHelper.labelStyle(errorText: errorText.value),
                        enabled: enabled,
                        border: TextFormHelper.defaultOutlineInputBorder(errorText: errorText.value),
                        enabledBorder: TextFormHelper.defaultEnabledOutlineInputBorder(),
                        disabledBorder: TextFormHelper.defaultDisabledOutlineInputBorder(),
                        focusedBorder: TextFormHelper.defaultFocusedOutlineInputBorder(errorText: errorText.value),
                        errorBorder: TextFormHelper.defaultErrorOutlineInputBorder(errorText: errorText.value),
                        focusedErrorBorder: TextFormHelper.defaultErrorOutlineInputBorder(),
                      ),
                ),
              ),

              Container(
                padding: const EdgeInsets.only(top: 17, bottom: 17, right: 10),
                child: const VerticalDivider(
                  color: ColorUtils.kGreyBorderColor,
                  thickness: 1,
                ),
              ),

              Expanded(
                flex: 40,
                  child: dropDownWidget(dataModel, dropDownSelectedVal)
              ),

            ],
          ),
        ),


        if (errorText.value != null)...[
          const SizedBox(height: 5),
          AppTextV2(
            data: errorText.value ?? '',
            fontSize: 10,
            fontColor: ColorUtilsV2.specialDestructive400,
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ],
      ],
    );
  }

  Widget dropDownWidget(List<dynamic> dropDownVal, String selectedValue) {

    return DropdownButton(
      underline: const SizedBox(),
      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: ColorUtils.midLightGrey,),
      items: dropDownVal.map((item) {
        return DropdownMenuItem(
          value: item.displayName.toString(),
          child: AppTextV2(
            data: item.displayName.toString(),
            fontSize: FontSizes.textSize14,
            fontWeight: FontWeight.w600,
            fontColor: ColorUtils.darkestBlue,
          ),
        );
      }).toList(),
      onChanged: onChangedDropDown,
      value: selectedValue,
    );
  }
}
