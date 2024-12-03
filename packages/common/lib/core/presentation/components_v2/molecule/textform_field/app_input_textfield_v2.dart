import 'package:common/core/presentation/components_v2/molecule/textform_field/textform_helper.dart';
import 'package:common/core/presentation/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/app_string_constants.dart';
import '../../../utils/riverpod_framework.dart';
import '../../app_text_v2.dart';
import '../../color_utils_v2.dart';

class AppInputTextFieldV2 extends HookWidget {
  final TextEditingController? controller;
  final Function()? onInputTap;
  final Function(PointerDownEvent)? onTapOutside;
  final TextInputAction? inputAction;
  final TextInputType? inputType;
  final String? labelText;
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
  final double errorTextSize;
  final Color? cursorColor;
  final bool callOnChangeFirst;
  final bool? enableInteractiveSelection;
  final bool invalidate;
  final bool? listenerNeeded;
  final FocusNode? focusNode;
  final TextStyle? labelStyle;
  final TextStyle? floatingLabelStyle;
  final bool validateInitially;
  final InputBorder? disabledBorder;
  final InputBorder? enabledBorder;
  final InputBorder? focussedBorder;

  const AppInputTextFieldV2(
      {super.key,
      this.controller,
      this.onInputTap,
      this.onTapOutside,
      this.inputAction,
      this.inputType,
      this.labelText,
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
          const EdgeInsets.symmetric(vertical: 17, horizontal: 22),
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
      this.errorTextSize = 10,
      this.callOnChangeFirst = false,
      this.cursorColor,
      this.enableInteractiveSelection = true,
      this.invalidate = false,
      this.focusNode,
      this.labelStyle,
      this.floatingLabelStyle,
      this.disabledBorder,
      this.enabledBorder,
      this.focussedBorder,
      this.validateInitially = false});

  @override
  Widget build(BuildContext context) {
    final errorText = useState<String?>(null);

    useEffect(() {
      if (controller != null) {
        if (listenerNeeded ?? true) {
          controller!.addListener(() {
            if (!context.mounted) return;
            var error = validator?.call(controller!.text);
            if (error != errorText.value) {
              if (error != null && error.isNotEmpty) {
                errorText.value = error;
              } else {
                errorText.value = null;
              }
            }
          });
        }
      }
      if (validateInitially == true && initialValue?.isNotEmpty == true) {
        var error = validator?.call(initialValue);
        if (error != errorText.value) {
          if (error != null && error.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              errorText.value = error;
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              errorText.value = null;
            });
          }
        }
      }
      return null;
    }, []);

    useEffect(() {
      errorText.value = null;
      return null;
    }, [invalidate]);

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
                  defaultColor: textColor,
                  errorText: errorText.value,
                  textLineHeight: textLineHeight),
          // cursorHeight: fontSize,
          cursorColor: cursorColor,
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
          keyboardType: inputType,
          showCursor: showCursor,
          onChanged: (value) {
            if (callOnChangeFirst) {
              onChanged?.call(value);
            }
            var error = validator?.call(value);
            if (error != null && error.isNotEmpty) {
              errorText.value = error;
            } else {
              errorText.value = null;
            }
            if (!callOnChangeFirst) {
              onChanged?.call(value);
            }
          },
          onTap: () => onInputTap?.call(),
          onTapOutside: onTapOutside,
          decoration: inputDecoration ??
              InputDecoration(
                floatingLabelStyle: floatingLabelStyle,
                counterText: counterText,
                alignLabelWithHint: true,
                contentPadding: contentPadding,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                prefixText: prefixText,
                suffixText: suffixText,
                hintText: hintText,
                suffixStyle: suffixTextStyle,
                prefixStyle: errorText.value.isNullOrEmpty()
                    ? prefixTextStyle
                    : prefixTextStyle?.copyWith(color: errorTextColor),
                hintStyle: TextFormHelper.hintStyle(),
                labelText: labelText,
                enabled: enabled,
                errorMaxLines: 2,
                // errorText: '---',
                errorStyle:
                    const TextStyle(color: Colors.transparent, fontSize: 10),
                labelStyle: labelStyle ??
                    TextFormHelper.labelStyle(
                        errorText: errorText.value, color: textColor),
                border: TextFormHelper.defaultOutlineInputBorder(
                    errorText: errorText.value),
                enabledBorder: enabledBorder ??
                    TextFormHelper.defaultEnabledOutlineInputBorder(
                        color: textColor),
                disabledBorder: disabledBorder ??
                    TextFormHelper.defaultDisabledOutlineInputBorder(),
                focusedBorder: focussedBorder ??
                    TextFormHelper.defaultFocusedOutlineInputBorder(
                        errorText: errorText.value),
                errorBorder: TextFormHelper.defaultErrorOutlineInputBorder(
                    errorText: errorText.value),
                focusedErrorBorder:
                    TextFormHelper.defaultErrorOutlineInputBorder(),
              ),
        ),
        if (errorText.value != null) ...[
          const SizedBox(height: 5),
          AppTextV2(
            data: errorText.value ?? '',
            fontSize: errorTextSize,
            fontColor: errorTextColor,
            fontWeight: FontWeight.w500,
            height: 0,
            textAlign: TextAlign.start,
          ),
        ],
      ],
    );
  }
}

//can expand
class AppInputTextFieldV4 extends HookWidget {
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
  final double errorTextSize;
  final Color? cursorColor;
  final bool callOnChangeFirst;
  final bool? enableInteractiveSelection;
  final bool invalidate;
  final bool? listenerNeeded;
  final FocusNode? focusNode;
  final TextStyle? labelStyle;
  final TextStyle? floatingLabelStyle;
  final double? height;
  final InputBorder? disabledBorder;
  final InputBorder? enabledBorder;
  final InputBorder? focussedBorder;

  const AppInputTextFieldV4(
      {super.key,
      this.controller,
      this.height,
      this.onInputTap,
      this.inputAction,
      this.inputType,
      this.labelText,
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
          const EdgeInsets.symmetric(vertical: 17, horizontal: 22),
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
      this.errorTextSize = 10,
      this.callOnChangeFirst = false,
      this.cursorColor,
      this.enableInteractiveSelection = true,
      this.invalidate = false,
      this.focusNode,
      this.floatingLabelStyle,
      this.disabledBorder,
      this.enabledBorder,
      this.focussedBorder,
      this.labelStyle});

  @override
  Widget build(BuildContext context) {
    final errorText = useState<String?>(null);

    useEffect(() {
      if (controller != null) {
        if (listenerNeeded ?? true) {
          controller!.addListener(() {
            if (!context.mounted) return;
            var error = validator?.call(controller!.text);
            if (error != errorText.value) {
              if (error != null && error.isNotEmpty) {
                errorText.value = error;
              } else {
                errorText.value = null;
              }
            }
          });
        }
      }
      return null;
    }, []);

    useEffect(() {
      errorText.value = null;
      return null;
    }, [invalidate]);

    return SizedBox(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: TextFormField(
              expands: true,
              enableInteractiveSelection: enableInteractiveSelection,
              focusNode: focusNode,
              controller: controller,
              textAlign: textAlign,
              textAlignVertical: TextAlignVertical.top,
              style: textStyle ??
                  TextFormHelper.defaultTextStyle(
                      fontSize: fontSize,
                      defaultColor: textColor,
                      errorText: errorText.value,
                      textLineHeight: textLineHeight),
              // cursorHeight: fontSize,
              cursorColor: cursorColor,
              initialValue: initialValue,
              inputFormatters: inputFormatters,
              textInputAction: inputAction,
              autovalidateMode: autoValidateMode,
              maxLines: null,
              minLines: null,
              maxLength: maxLength,
              readOnly: readOnly,
              obscureText: obscureText,
              obscuringCharacter: obscuringCharacter,
              autofocus: autoFocus,
              enabled: enabled,
              keyboardType: inputType,
              showCursor: showCursor,
              onChanged: (value) {
                if (callOnChangeFirst) {
                  onChanged?.call(value);
                }
                var error = validator?.call(value);
                if (error != null && error.isNotEmpty) {
                  errorText.value = error;
                } else {
                  errorText.value = null;
                }
                if (!callOnChangeFirst) {
                  onChanged?.call(value);
                }
              },
              onTap: () => onInputTap?.call(),
              decoration: inputDecoration ??
                  InputDecoration(
                    floatingLabelStyle: floatingLabelStyle,
                    isDense: false,
                    isCollapsed: false,
                    counterText: counterText,
                    alignLabelWithHint: true,
                    contentPadding: contentPadding,
                    prefixIcon: prefixIcon,
                    suffixIcon: suffixIcon,
                    prefixText: prefixText,
                    suffixText: suffixText,
                    suffixStyle: suffixTextStyle,
                    prefixStyle: errorText.value.isNullOrEmpty()
                        ? prefixTextStyle
                        : prefixTextStyle?.copyWith(color: errorTextColor),
                    hintStyle: TextFormHelper.hintStyle(),
                    labelText: labelText,
                    enabled: enabled,
                    errorMaxLines: 2,
                    // errorText: '---',
                    errorStyle: const TextStyle(
                        color: Colors.transparent, fontSize: 10),
                    labelStyle: labelStyle ??
                        TextFormHelper.labelStyle(
                            errorText: errorText.value, color: textColor),
                    border: TextFormHelper.defaultOutlineInputBorder(
                        errorText: errorText.value),
                    enabledBorder: enabledBorder ??
                        TextFormHelper.defaultEnabledOutlineInputBorder(
                            color: textColor),
                    disabledBorder: disabledBorder ??
                        TextFormHelper.defaultDisabledOutlineInputBorder(),
                    focusedBorder: focussedBorder ??
                        TextFormHelper.defaultFocusedOutlineInputBorder(
                            errorText: errorText.value),
                    errorBorder: TextFormHelper.defaultErrorOutlineInputBorder(
                        errorText: errorText.value),
                    focusedErrorBorder:
                        TextFormHelper.defaultErrorOutlineInputBorder(),
                  ),
            ),
          ),
          if (errorText.value != null) ...[
            const SizedBox(height: 5),
            AppTextV2(
              data: errorText.value ?? '',
              fontSize: errorTextSize,
              fontColor: errorTextColor,
              fontWeight: FontWeight.w500,
              height: 0,
              textAlign: TextAlign.start,
            ),
          ],
        ],
      ),
    );
  }
}
