import 'package:flutter/services.dart';

class IFSCCodeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text.toUpperCase();

    if (newText.length <= 4) {
      return TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(offset: newText.length));
    } else if (newText.length == 5) {
      if (newText[4] != '0') {
        return oldValue;
      }
    } else if (newText.length > 11) {
      // If length exceeds 11, return old value
      return oldValue;
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
