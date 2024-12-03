import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/utils/extensions/string_extension.dart';
import 'package:common/core/presentation/utils/input_formatter/input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AppDateUtils {
  static AppDateUtils? _singleton;

  AppDateUtils._();

  factory AppDateUtils() {
    _singleton ??= AppDateUtils._();
    return _singleton!;
  }

  static const String DOB_DATE_FORMAT = "dd/MM/yyyy";
  static const String SIP_DATE_FORMAT = "dd/MM/yyyy";
  static const String NAV_DATE_FORMAT = "dd MMM yyyy";
  static const String API_DATE_FORMAT = "yyyy-MM-dd";
  // static const String HYPERVERGE_DIGILOCKER_DATE_FORMAT = "dd-MM-yyyy";

  static Future<DateTime?> openDatePicker(
      {required BuildContext context,
      required DateTime initialDate,
      required DateTime firstDate,
      required DateTime lastDate,
      DatePickerEntryMode datePickerEntryMode =
          DatePickerEntryMode.calendarOnly, ThemeData? themeData}) async {
    final DateTime? picked = await showDatePicker(
        initialEntryMode: datePickerEntryMode,
        locale: const Locale('en', 'IN'),
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        builder: (_, child) {
          return Theme(
            data:themeData?? Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: ColorUtilsV2.specialBackground500,
                onPrimary: Colors.white,
                onSurface: ColorUtilsV2.specialNeutral700,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: ColorUtilsV2.specialBackground500,
                ),
              ),
            ),
            child: child!,
          );
        });
    return picked;
  }

  static Future<DateTime?> openDobDatePicker({
    required BuildContext context,
    required DateTime? initialDate,
    int startYear = 70,
    DateTime? firstDate,
    DateTime? endDate,
    ThemeData? themeData
    }) async {
    var now = DateTime.now();
    final DateTime? picked = await openDatePicker(
      themeData: themeData,
      context: context,
      initialDate: initialDate ?? now.subtract(const Duration(days: (30 * 365))),
      firstDate: firstDate ?? now.subtract(Duration(days: (startYear * 365))),
      lastDate: endDate ?? now,
    );
    return picked;
  }
  
  List<TextInputFormatter>? get dobsInputFormatters => [
        DateTextFormatter(),
        FilteringTextInputFormatter.allow(RegExp('[0-9.,//]')),
        LengthLimitingTextInputFormatter(10),
      ];

  DateTime? convertToDateTime(String? input,
      {String format = DOB_DATE_FORMAT}) {
    if (input.isNullOrEmpty()) return null;
    try {
      return DateFormat(format).parse(input!);
    } catch (e) {
      return null;
    }
  }

  //converst from 2024-03-10 10:30:00 format to February 10, 2024
  String getFormattedDate(String date) {
    try {
      DateTime dateTime = DateTime.parse(date);
      // Format the date using DateFormat
      return DateFormat('MMMM d, yyyy').format(dateTime);
    } catch (e) {
      return "";
    }
  }

  static int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;

    // Check if birth month is yet to come or it is the birth month but the day hasn't come yet
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }

    return age;
  }
 /// Function to get current date as String
  /// dd MMM yyyy format by default
  String getCurrentDate({DateFormat? dateFormat}){
    try{
      var now = DateTime.now();
      var formatter = dateFormat ?? DateFormat('dd MMM yyyy');
      String formattedDate = formatter.format(now);
      return formattedDate;
    }catch(e){
      debugPrint("Date Format Error: $e");
      return "";
    }
  }

  static int calculateAgeFromStringDob(String dob) {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    DateTime birthDate = dateFormat.parse(dob);
    DateTime currentDate = DateTime.now();

    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;

    // Adjust age if current date is before the birthday in the current year
    if (month2 > month1 || (month2 == month1 && currentDate.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  int getAgeInMonths(DateTime dateTime) {
    var cur = DateTime.now();
    int yrs = cur.year - dateTime.year;
    int month = 0;

    if (cur.month > dateTime.month) {
      month = cur.month - dateTime.month;
    } else if (cur.month < dateTime.month) {
      --yrs;
      month = (12 - dateTime.month) + cur.month;
    }
    return (yrs * 12) + month;
  }

  /// If input dateTime is 2000 Oct and current date is 2024 June
  /// output will be "23yrs 8m"
  String getAgeInYearsMonth(DateTime? dateTime, {String yearStr = "yrs", String monthStr = "m"}) {
    if(dateTime == null) return "-";
    var months = getAgeInMonths(dateTime);
    var m = months % 12;
    var y = months ~/ 12;

    if (y == 0) {
      return "$m$monthStr";
    } else if (m == 0) {
      return "$y$yearStr";
    } else {
      return "$y$yearStr $m$monthStr";
    }
  }
}
