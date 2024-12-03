import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/services.dart';

class IndianNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(',', '');

    if (newText.isNotEmpty) {
      final value = int.parse(newText);
      final formatter = NumberFormat('#,##,###');
      newText = formatter.format(value);
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
