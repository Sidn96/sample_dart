import 'package:flutter/material.dart';

import '../../../profile/presentation/common_imports.dart';

class PickDate {
  PickDate._();

  static Future<DateTime?> selectDate(
      {required BuildContext context,
        required DateTime initialDate,
        required DateTime firstDate,
        required DateTime lastDate}) async {
    final DateTime? picked = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      locale: const Locale('en', 'IN'),
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    return picked;
  }

  /// convert a dateTime to a string
  static String? getDateOfString(DateTime? dateTime) {
    String date;
    final DateFormat formatter = DateFormat("dd/MM/yyyy");
    if (dateTime != null) {
      if (dateTime != DateTime.now()) {
        date = formatter.format(dateTime);
        return date;
      } else {
        return null;
      }
    }
    return null;
  }
}