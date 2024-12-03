import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/font_styles.dart';
import 'package:common/core/presentation/widgets/text_field_light_grey_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldLightGreyBorder extends StatelessWidget {
  final String? label;
  final String? hintText;
  final String? errorText;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final Widget? prefixWidget;
  final Widget? sufixWidget;
  final Function(String)? onChanged;
  final AutovalidateMode? autoValidateMode;
  final bool? isEnable;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Color? disableColor;
  final Function(PointerDownEvent)? onTapOutside;
  final TextCapitalization? textCapitalization;
  final int? maxLength;
  final TextInputAction? inputAction;
  final Function(String)? onFieldSubmitted;
  final int? maxLines;
  final Widget? sufixIcon;
  final Function()? onTap;
  final Color? hintTextColor;
  final Color? enableBorderColor;
  final Color? focusedBorderColor;
  final Color? disableBorderColor;
  final bool readOnly;
  final EdgeInsetsGeometry? contentPadding;
  final String? initialValue;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final Function()? onEditingComplete;
  final double? hintTextSize;
  final Color? fillColor;
  final Color? labelColor;
  final Color? valueColor;
  final double? hintTextHeight;
  final Widget? prefixIcon;
  const TextFieldLightGreyBorder({
    super.key,
    this.initialValue,
    this.label,
    this.hintText,
    this.errorText,
    this.inputType,
    this.onChanged,
    this.floatingLabelBehavior,
    this.controller,
    this.autoValidateMode,
    this.textCapitalization,
    this.prefixWidget,
    this.inputFormatters,
    this.validator,
    this.isEnable = true,
    this.disableColor,
    this.onTapOutside,
    this.inputAction,
    this.onFieldSubmitted,
    this.maxLength,
    this.maxLines = 1,
    this.sufixWidget,
    this.sufixIcon,
    this.onTap,
    this.hintTextColor,
    this.enableBorderColor,
    this.focusedBorderColor,
    this.disableBorderColor,
    this.readOnly = false,
    this.contentPadding,
    this.onEditingComplete,
    this.hintTextSize,
    this.fillColor,
    this.labelColor,
    this.valueColor,
    this.hintTextHeight,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      initialValue: initialValue,
      onTapOutside: (v) {
        FocusManager.instance.primaryFocus?.unfocus();
        onTapOutside?.call(v);
      },
      onTap: onTap,
      controller: controller,
      autovalidateMode: autoValidateMode ?? AutovalidateMode.onUserInteraction,
      textInputAction: inputAction,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      keyboardType: inputType,
      enabled: isEnable,
      inputFormatters: inputFormatters,
      style: FontStyles.interStyle(
        textColor: valueColor ?? ColorUtils.bluishblack,
        height: 1.3,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      decoration: textFieldLightGreyDecoration(
        label: label,
        labelColor: labelColor,
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintTextSize: hintTextSize,
        hintTextHeight: hintTextHeight,
        prefixWidget: prefixWidget,
        floatingLabelBehavior: floatingLabelBehavior,
        errorText: errorText,
        sufixWidget: sufixWidget,
        sufixIcon: sufixIcon,
        fillColor: fillColor,
        contentPadding: contentPadding,
        hintTextColor: hintTextColor,
        enableBorderColor: enableBorderColor ?? ColorUtils.kbuttondisableText,
        disableBorderColor: disableBorderColor ?? ColorUtils.taxdarkGray,
        focusedBorderColor: focusedBorderColor ?? ColorUtils.bluishblack,
      ),
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      maxLength: maxLength,
      maxLines: maxLines,
    );
  }
}
