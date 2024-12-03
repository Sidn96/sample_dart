import 'package:flutter/material.dart';

extension TextEditingControllerExtenstion on TextEditingController {
  void moveCursorToLast() {
    selection = TextSelection.collapsed(offset: text.length);
  }
}