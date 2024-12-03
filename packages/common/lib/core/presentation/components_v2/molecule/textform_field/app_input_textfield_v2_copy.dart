import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/components_v2/molecule/textform_field/textform_helper.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppInputTextFieldV3 extends HookWidget {
  final TextEditingController? controller;
  final Function()? onInputTap;
  final TextInputAction? inputAction;
  final TextInputType? inputType;
  final String? labelText;
  final Color? labelColor;
  final String? hintText;
  final String? initialValue;
  final bool autoFocus;
  final AutovalidateMode? autoValidateMode;

  final FormFieldValidator<String>? validator;

  // final Function(String?)? validator;
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
  final String? suffixText;
  final TextStyle? prefixTextStyle;
  final TextStyle? suffixTextStyle;
  final TextStyle? textStyle;
  final double? textLineHeight;
  final String? counterText;
  final Color? errorTextColor;
  final Color? cursorColor;
  final bool callOnChangeFirst;
  final bool? enableInteractiveSelection;
  final bool invalidate;
  final bool? listenerNeeded;
  final FocusNode? focusNode;
  final double? errorFontSize;
  final bool textOnly;

  const AppInputTextFieldV3(
      {super.key,
        this.controller,
        this.onInputTap,
        this.inputAction,
        this.inputType,
        this.labelText,
        this.labelColor,
        this.hintText,
        this.initialValue,
        this.autoFocus = false,
        this.autoValidateMode = AutovalidateMode.onUserInteraction,
        this.validator,
        this.onChanged,
        this.listenerNeeded,
        this.readOnly = false,
        this.maxLines = 1,
        this.maxLength = 50,
        this.obscureText = false,
        this.obscuringCharacter = AppConstants.symbolStar,
        this.suffixIcon,
        this.prefixIcon,
        this.textAlign = TextAlign.start,
        this.inputFormatters,
        this.busy = false,
        this.fontSize = 16,
        this.labelFontSize,
        this.fontWeight,
        this.textColor,
        this.contentPadding =
        const EdgeInsets.only(left: 22, top: 17, right: 22, bottom: 17),
        this.hintColor,
        this.enabled = true,
        this.showCursor,
        this.inputDecoration,
        this.prefixText,
        this.suffixText,
        this.prefixTextStyle,
        this.suffixTextStyle,
        this.textStyle,
        this.textLineHeight,
        this.counterText = '',
        this.errorTextColor = ColorUtilsV2.specialDestructive400,
        this.callOnChangeFirst = false,
        this.cursorColor,
        this.enableInteractiveSelection = true,
        this.invalidate = false,
        this.focusNode,
        this.errorFontSize = 10,
        this.textOnly = false});

  @override
  Widget build(BuildContext context) {
    //  final errorText = useState<String?>(null);

    // useEffect(() {
    //   if (controller != null) {
    //     if (listenerNeeded ?? true) {
    //       controller!.addListener(() {
    //         if (!context.mounted) return;
    //         var error = validator?.call(controller!.text);
    //         if (error != errorText.value) {
    //           if (error != null && error.isNotEmpty) {
    //             errorText.value = error;
    //           } else {
    //             errorText.value = null;
    //           }
    //         }
    //       });
    //     }
    //   }
    //   return null;
    // }, []);
    //
    // useEffect(() {
    //   // errorText.value = null;
    //   return null;
    // }, [invalidate]);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          enableInteractiveSelection: enableInteractiveSelection,
          focusNode: focusNode,
          controller: controller,
          textAlign: textAlign,
          style: textStyle ??
              TextFormHelper.defaultTextStyle(
                  fontSize: fontSize,
                  defaultColor: enabled ? textColor : Colors.grey,
                  //errorText: errorText.value,
                  textLineHeight: textLineHeight),
          //cursorHeight: fontSize,
          cursorColor: cursorColor,
          initialValue: initialValue,
          inputFormatters: inputFormatters ??
              (textOnly
                  ? [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))]
                  : inputFormatters),
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
          keyboardType: inputType ?? (textOnly ? TextInputType.text : inputType),
          showCursor: showCursor,
          validator: (value) => validator?.call(value),
          onChanged: (value) {
            if (callOnChangeFirst) {
              onChanged?.call(value);
            }
            // var error = validator?.call(value);
            // if (error != null && error.isNotEmpty) {
            //   errorText.value = error;
            // } else {
            //   errorText.value = null;
            // }
            if (!callOnChangeFirst) {
              onChanged?.call(value);
            }
          },
          onTap: () => onInputTap?.call(),
          decoration: inputDecoration ??
              InputDecoration(
                counterText: counterText,
                alignLabelWithHint: true,
                contentPadding: contentPadding,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                prefixStyle: prefixTextStyle,
                prefixText: prefixText,
                suffixText: suffixText,
                suffixStyle: suffixTextStyle,
                // prefixStyle: errorText.value.isNullOrEmpty()
                //     ? prefixTextStyle
                //     : prefixTextStyle?.copyWith(color: errorTextColor),
                hintStyle: TextFormHelper.hintStyle(),
                labelText: labelText,
                enabled: enabled,
                errorMaxLines: 2,
                // errorText: '---',
                errorStyle:  TextStyle(color: ColorUtilsV2.specialDestructive400, fontSize: errorFontSize,),
                labelStyle: TextFormHelper.labelStyle(color: labelColor ?? textColor),
                border: TextFormHelper.defaultOutlineInputBorder(),
                enabledBorder: TextFormHelper.defaultEnabledOutlineInputBorder(
                    color: textColor),
                disabledBorder:
                TextFormHelper.defaultDisabledOutlineInputBorder(),
                focusedBorder:
                TextFormHelper.defaultFocusedOutlineInputBorder(),
                errorBorder: TextFormHelper.defaultErrorOutlineInputBorder(),
                focusedErrorBorder:
                TextFormHelper.defaultErrorOutlineInputBorder(),
              ),
        ),
        // if (errorText.value != null) ...[
        //   const SizedBox(height: 5),
        //   AppTextV2(
        //     data: errorText.value ?? '',
        //     fontSize: 10,
        //     fontColor: errorTextColor,
        //     fontWeight: FontWeight.w500,
        //     height: 0,
        //     textAlign: TextAlign.start,
        //   ),
        // ],
      ],
    );
  }
}