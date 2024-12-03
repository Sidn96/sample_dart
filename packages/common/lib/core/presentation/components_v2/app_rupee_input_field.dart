import 'package:common/core/presentation/components_v2/components_v2.dart';
import 'package:common/core/presentation/extensions/price_format_extension.dart';
import 'package:common/core/presentation/utils/number_formatter.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppRupeeInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final bool? isFromEditFlow;
  final Function(String)? onChanged;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final TextInputFormatter? maxInputFormatter;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final FocusNode? focusNode;

  const AppRupeeInputField({
    super.key,
    required this.controller,
    this.labelText,
    this.isFromEditFlow,
    this.inputFormatters,
    this.onChanged,
    this.validator,
    this.suffixIcon,
    this.maxInputFormatter,
    this.enabled,this.focusNode,

  });

  @override
  Widget build(BuildContext context) {
    return AppInputTextFieldV2(
      focusNode:focusNode,
      enabled: enabled ?? true,
      enableInteractiveSelection: false,
      key: key,
      labelText: labelText,
      hintText: '',
      suffixIcon: suffixIcon,
      textColor: (isFromEditFlow ?? false) ? ColorUtils.white : null,
      cursorColor: (isFromEditFlow ?? false) ? ColorUtils.white : null,
      inputType: TextInputType.number,
      inputAction: TextInputAction.done,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: inputFormatters ??
          [
            FilteringTextInputFormatter.digitsOnly,
            // FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            maxInputFormatter ??
                NumericalRangeFormatter(min: 0, max: 999999999),
          ],
      fontSize: 16,
      prefixText: ' ${AppConstants.rupeeSymbol} ',
      prefixTextStyle: TextStyles.manropeStyle(
        16,
        color: (isFromEditFlow ?? false)
            ? ColorUtils.white
            : ColorUtilsV2.specialNeutral700,
        fontWeight: FontWeight.w500,
      ),
      controller: controller,
      onChanged: onChanged ??
          (value) {
            if (value.isNotEmpty) {
              var newVal =
                  int.parse(value.replaceAll(",", "")).toPriceFormatter();
              controller.text = newVal;
              controller.selection =
                  TextSelection.collapsed(offset: newVal.length);
            }
          },
      validator: (v) => validator?.call(v),
    );
  }
}
