import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../styles/color_utils.dart';
import '../styles/font_styles.dart';
import '../styles/sizes.dart';

class AppTextFormFiled extends StatefulWidget {
  final double? height;
  final double? textHeight;
  final double? width;
  final Widget? child;
  final Function()? onPressed;
  final TextEditingController? controller;
  final TextInputAction? inputAction;
  final TextInputType? inputType;
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final bool? autoFocus;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final FormFieldSetter<String>? onSaved;
  final Function(String)? onFieldSubmitted;
  final bool? readOnly;
  final int? maxLength;
  final bool? obscureText;
  final String? obscuringCharacter;
  final Widget? suffixIcon;
  final Widget? suffix;
  final bool? isDense;
  final TextCapitalization? textCapitalization;

  @override
  final Key? key;
  final Widget? prefix;
  final Widget? prefixIcon;
  final bool? enabled;
  final InputBorder? inputBorder;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextStyle? labelStyle;
  final TextStyle? floatinglabelStyle;
  final InputBorder? enableBorder;
  final InputBorder? focusBorder;
  final InputBorder? disableBorder;
  final AutovalidateMode? autoValidateMode;
  final EdgeInsetsGeometry? contentPadding;
  final Color? cursorColor;
  final InputDecoration? inputDecoration;
  final Widget? labelWidget;
  final Color? textColor;
  final TextAlign textAlignment;
  final FocusNode? focusNode;
  final String? prefixText;
  final String? helperText;
  final TextStyle? prefixStyle;
  final double fontSize;
  final FontWeight fontWeight;

  final double errorFontSize;
  final FontWeight errorFontWeight;
  final double hintFontSize;
  final FontWeight hintFontWeight;
  final double? hintHeight;
  final Color? errorColor;
  final Function(PointerDownEvent)? onTapOutside;
  final bool enableInteractiveSelection;

  const AppTextFormFiled({
    this.height,
    this.width,
    this.child,
    this.textCapitalization,
    this.isDense,
    this.onPressed,
    this.controller,
    this.inputAction,
    this.cursorColor,
    this.inputType,
    this.labelText,
    this.hintText,
    this.floatinglabelStyle,
    this.initialValue,
    this.inputDecoration,
    this.autoFocus = false,
    this.validator,
    this.onSaved,
    this.readOnly = false,
    this.maxLength,
    this.key,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.suffixIcon,
    this.prefix,
    this.prefixIcon,
    this.enabled = true,
    this.disableBorder,
    this.inputFormatters,
    this.maxLines = 10,
    this.minLines = 1,
    this.onChanged,
    this.onFieldSubmitted,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.labelStyle,
    this.inputBorder,
    this.enableBorder,
    this.focusBorder,
    this.autoValidateMode,
    this.onTapOutside,
    this.textColor,
    this.contentPadding =
        const EdgeInsets.only(left: 8, top: 16, bottom: 16, right: 8),
    this.textHeight = 1,
    this.labelWidget,
    this.textAlignment = TextAlign.start,
    this.focusNode,
    this.suffix,
    this.prefixText,
    this.helperText,
    this.prefixStyle,
    this.fontSize = Sizes.textSize16,
    this.fontWeight = FontWeight.w700,
    this.errorFontSize = Sizes.textSize16,
    this.errorFontWeight = FontWeight.w700,
    this.hintFontSize = Sizes.textSize16,
    this.hintFontWeight = FontWeight.w700,
    this.hintHeight = 1,
    this.errorColor = ColorUtils.errorColor,
    this.enableInteractiveSelection = false
  }) : super(key: key);

  @override
  AppTextFormFiledState createState() => AppTextFormFiledState();
}

class AppTextFormFiledState extends State<AppTextFormFiled> {
  bool _secureText = false;

  bool get secureText => _secureText;

  set secureText(bool value) {
    setState(() {
      _secureText = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.width,
        height: widget.height,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: TextFormField(
            enableInteractiveSelection: widget.enableInteractiveSelection,
            onTapOutside: widget.onTapOutside,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.none,
            autovalidateMode: widget.autoValidateMode,
            textAlign: widget.textAlignment,
            cursorColor: widget.cursorColor,
            maxLength: widget.maxLength,
            onTap: widget.onPressed,
            style: FontStyles.interStyle(
                height: widget.textHeight,
                fontSize: widget.fontSize,
                fontWeight: widget.fontWeight,
                textColor: widget.textColor),
            initialValue: widget.initialValue,
            autofocus: widget.autoFocus ?? false,
            textInputAction: widget.inputAction,
            keyboardType: widget.inputType,
            inputFormatters: widget.inputFormatters,
            readOnly: widget.readOnly ?? false,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            obscureText: secureText,
            obscuringCharacter: widget.obscuringCharacter ?? "*",
            decoration: widget.inputDecoration ??
                InputDecoration(
                  isDense: widget.isDense ?? true,
                  hintStyle: FontStyles.interStyle(
                      fontWeight: widget.hintFontWeight,
                      fontSize: widget.hintFontSize,
                      textColor: ColorUtils.kGreyBorderColor,
                      height: widget.hintHeight),
                  errorStyle: FontStyles.interStyle(
                      fontWeight: widget.hintFontWeight,
                      fontSize: Sizes.textSize12,
                      textColor: widget.errorColor),
                  border: widget.inputBorder,
                  prefixIcon: widget.prefixIcon,
                  prefixText: widget.prefixText,
                  prefixStyle: widget.prefixStyle,
                  prefix: widget.prefix,
                  floatingLabelStyle: widget.floatinglabelStyle,
                  labelStyle: widget.labelStyle,
                  labelText: widget.labelText,
                  helperText: widget.helperText,
                  contentPadding: widget.contentPadding,
                  hintText: widget.hintText,
                  label: widget.labelText == null ? widget.labelWidget : null,
                  hintMaxLines: 1,
                  counterText: "",
                  suffixIcon: widget.suffixIcon,
                  suffix: widget.suffix,
                  enabled: widget.enabled ?? true,
                  floatingLabelBehavior: widget.floatingLabelBehavior,
                  enabledBorder: widget.enableBorder,
                  focusedBorder: widget.focusBorder,
                  disabledBorder: widget.disableBorder,
                ),
            controller: widget.controller,
            validator: widget.validator,
            onSaved: widget.onSaved,
            onFieldSubmitted: widget.onFieldSubmitted,
            onChanged: (value) {
              widget.onChanged?.call(value);
            },
            focusNode: widget.focusNode,
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    _secureText = widget.obscureText ?? false;
  }
}
