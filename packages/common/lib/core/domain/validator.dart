import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Validator {
  static const validDOBPattern =
      r"^(((0[1-9]|[12][0-9]|3[01])[- /.](0[13578]|1[02])|(0[1-9]|[12][0-9]|30)[- /.](0[469]|11)|(0[1-9]|1\d|2[0-8])[- /.]02)[- /.]\d{4}|29[- /.]02[- /.](\d{2}(0[48]|[2468][048]|[13579][26])|([02468][048]|[1359][26])00))$";

  static bool validateEmail(String email) {
    //   r'^[\w-\.]{3,30}@([\w-]+\.)+[\w-]{2,4}$'
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }

  //set limit for text field upto 100 characters
  static bool isCharacterLimitValid(String data) {
    if (data.trim().length >= 50 && data.trim().length <= 1000) {
      return true;
    } else {
      return false;
    }
  }

  static bool isEmpty(String data) {
    return data.isEmpty;
  }

  ///pran no. validation (not empty and should ne 12 digit)
  static int pranNoValidation(String data) {
    if (data.isEmpty) {
      return 1;
    } else if (data.length < 12) {
      return 2;
    } else {
      return 0;
    }
  }

  ///phone no. validation (start no. 6-9 and 10 digits no.)
  static int phoneNoValidate(String value, {int? messageCode}) {
    Pattern pattern = r'^(?!(\d)\1{4,})([6789]\d{9})$';
    RegExp regex = RegExp(pattern.toString());

    if (value.isEmpty) {
      return 1;
    } else if (!regex.hasMatch(value)) {
      return 2;
    } else if (messageCode != null) {
      return messageCode;
    } else {
      return 0;
    }
  }

  static int fullNameValidate(String data) {
    if (data.isEmpty) {
      return 1;
    } else if (data.startsWith(" ") || data.trim().length < 3) {
      return 2;
    } else {
      return 0;
    }
  }

  static String? isNameValid(String? data) {
    String pattern = r'^[a-z A-Z]+$';
    RegExp regex = RegExp(pattern.toString());

    if (data == null ||
        data.trim().isEmpty ||
        data.trim().length < 2 ||
        data.startsWith(" ") ||
        !regex.hasMatch(data)) {
      return 'Please enter valid name';
    }
    return null;
  }

  ///otp validation (not less than 4)
  static int otpValidation(String value) {
    if (value.isEmpty) {
      return 1;
    } else if (value.length < 4) {
      return 2;
    } else {
      return 0;
    }
  }

  ///otp validation (not less than 6)
  static int otpValidationSixDigit(String value) {
    if (value.isEmpty) {
      return 1;
    } else if (value.length < 6) {
      return 2;
    } else {
      return 0;
    }
  }

  ///DOB validation (should be >18 and <70)
  static int ageValidation(DateTime value) {
    Duration difference = DateTime.now().difference(value);
    var diff = int.parse((difference.inDays / 365).floor().toString());
    print("DateDiff::$diff");

    if (diff < 18) {
      return 1; // for age less than 18
    } else if (diff > 70) {
      return 2; // for age greater than 70
    }
    return 0;
  }

  ///DOB validation method new
  static int validateDateOfBirth(String dob) {
    /// 0 = success, 1 = dob is empty, 2 = invalid dob, 3 = dob is > 70 yrs [permissible 70], 4 = age is < 18 yrs, 5 = future dob

    if (dob.isEmpty) {
      return 1;
    }
    if (dob.length != 10 || !RegExp(validDOBPattern.toString()).hasMatch(dob)) {
      return 2;
    } else {
      // final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final mDob = DateFormat('dd/MM/yyyy').parse(dob);

      // final String formatted = formatter.format(mDob);

      final diff = DateTime.now().difference(mDob);
      if (!(diff.inDays <= 25567)) {
        return 3;
      } else if (!(diff.inDays >= 6574)) {
        return 4;
      } else if (DateTime.now().isBefore(mDob)) {
        return 5;
      } else {
        return 0;
      }
    }
  }

  static int validateDojWithDob({required String dob, required String doj}) {
    /// 0 = success, 1 = empty doj, 2 = invalid dob, 3 = doj is before or same with dob, 4 = diff is < 18 yrs, 5 = diff is > 700 yrs

    if (dob.isEmpty) {
      return -1;
    } else if (dob.length != 10) {
      return -2;
    } else if (doj.isEmpty) {
      return -3;
    } else if (doj.length != 10) {
      return -4;
    }
    // if (dob.isEmpty || doj.isEmpty) {
    //   return 1;
    // } else if (dob.length != 10 || doj.length != 10) {
    //   return 1;
    // }

    try {
      final now = DateTime.now();
      final mDob = DateFormat('dd/MM/yyyy').parse(dob.trim());
      final mDoj = DateFormat('dd/MM/yyyy').parse(doj.trim());
      final diff = mDoj.difference(mDob);
      debugPrint('diff: $diff');

      if (!RegExp(validDOBPattern.toString()).hasMatch(doj)) {
        return 2;
      } else if (mDoj.isBefore(mDob) || mDoj.isAtSameMomentAs(mDob)) {
        return 3;
      } else if (!(diff.inDays >= 6574)) {
        return 4;
      } else if (!(diff.inDays <= 25567)) {
        return 5;
      } else if (mDoj.isAfter(now) || mDoj.isAtSameMomentAs(now)) {
        return 6;
      } else {
        return 0;
      }
    } catch (e) {
      debugPrint('validateDojWithDob: $e');
    }
    return 2;
  }

  static bool isPercent(double value) {
    return 0 <= value && value <= 1;
  }

  /// mas and min limit validation
  static bool validateMaxMinLimit(
      {required int value, required int maxValue, int minValue = 0}) {
    return value <= maxValue && value >= minValue ? true : false;
  }

  static bool validateExactLength(
      {required int textLength, required int value}) {
    return textLength == value ? true : false;
  }

  static bool reConfirmField(
      {required String mainValue, required String confirmValue}) {
    return mainValue == confirmValue ? true : false;
  }

  static int getCurrentAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  /// Only for NPS Buy Journey
  static bool isValidPan(String value) {
    return RegExp(r'^[A-Z]{3}[P]{1}[A-Z]{1}[0-9]{4}[A-Z]{1}$').hasMatch(value);
  }

  static bool isValidPanPattern(String value) {
    // return RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(value);
    /// Fourth character either P or H
    bool isValid = false;
    isValid =
        RegExp(r'^[A-Z]{3}[PH]{1}[A-Z]{1}[0-9]{4}[A-Z]{1}$').hasMatch(value);
    //debugPrint("isValidPan $isValid");
    return isValid;
  }

  static bool isValidPanPatternForMf(String value) {
    // return RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(value);
    /// Fourth character for C,P,H,F,A,T,B,L,J,G
    bool isValid = false;
    isValid =
        RegExp(r'^[A-Z]{3}[CPHFATBLJG]{1}[A-Z]{1}[0-9]{4}[A-Z]{1}$').hasMatch(value);
    //debugPrint("isValidPan $isValid");
    return isValid;
  }

  static bool isPinCodeSixDigit(String value) {
    bool isValid = false;
    isValid = value.length == 6;
    return isValid;
  }

  static bool isValueMoreThanMinimum(int inputValue, int expectedValue) {
    return inputValue >= expectedValue;
  }

  static bool isAmountMultiplesOfValue(int amount, int multiplesOf) {
    return (amount % multiplesOf == 0);
  }

  static bool isAmountLesserThanMaximum(int inputValue, int maxValue) {
    return inputValue <= maxValue;
  }

  static bool isValidIDSC(String value) {
    bool isValid = false;
    isValid = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(value);
    return isValid;
  }

  static bool isValidBankACNum(String value) {
    bool isValid = false;
    isValid = RegExp(r'^[0-9]{9,18}$').hasMatch(value);
    return isValid;
  }
}
