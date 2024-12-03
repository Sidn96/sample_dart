import 'package:common/core/presentation/extensions/price_format_extension.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:intl/intl.dart' show NumberFormat;

/// To format the number into readable currency
extension NumberFormatter on num {
  String formatToIndianHumanReadable() {
    String getStringAsTrimmedPrecision(num n, {int precision = 2}) =>
        num.parse(n.toStringAsPrecision(precision)).toString();

    try {
      if (this < 0) {
        return "-${abs().formatToIndianHumanReadable()}";
      } else if (this == 0) {
        return '0';
      } else if (this < 1000) {
        return getStringAsTrimmedPrecision(this);
      } else if (this < 100000) {
        return "${getStringAsTrimmedPrecision(this / 1000)}K";
      } else if (this < 10000000) {
        return "${getStringAsTrimmedPrecision(this / 100000)}L";
      } else if (this < 10000000000) {
        return "${getStringAsTrimmedPrecision(this / 10000000)}Cr";
      } else if (this < 1000000000000) {
        return "${getStringAsTrimmedPrecision(this / 10000000000)}K Cr";
      } else {
        return "${getStringAsTrimmedPrecision(this / 1000000000000)}L Cr";
      }
    } catch (e) {
      rethrow;
    }
  }
  String formatToIndianHumanReadableFull() {
    String getStringAsTrimmedPrecision(num n, {int precision = 2}) =>
        num.parse(n.toStringAsPrecision(precision)).toString();

    try {
      if (this < 0) {
        return "-${abs().formatToIndianHumanReadableFull()}";
      } else if (this == 0) {
        return '0';
      } else if (this < 1000) {
        return getStringAsTrimmedPrecision(this);
      } else if (this < 100000) {
        return "${getStringAsTrimmedPrecision(this / 1000)} Thousand";
      } else if (this < 10000000) {
        return "${getStringAsTrimmedPrecision(this / 100000)} Lac";
      } else if (this < 10000000000) {
        return "${getStringAsTrimmedPrecision(this / 10000000)} Crore";
      } else if (this < 1000000000000) {
        return "${getStringAsTrimmedPrecision(this / 10000000000)} Thousand Crore";
      } else {
        return "${getStringAsTrimmedPrecision(this / 1000000000000)} Lac Crore";
      }
    } catch (e) {
      rethrow;
    }
  }

  String formatToIndianHumanReadableWithRoundFiguresForRRR(
      {int? precisionA, bool? lastValue}) {
    String getStringAsTrimmedPrecision(num n, {int precision = 2}) =>
        num.parse(n.toStringAsPrecision(precisionA ?? precision)).toString();
    try {
      if (this < 0) {
        return "-${abs().formatToIndianHumanReadable()}";
      } else if (this == 0) {
        return '0';
      } else if (this < 1000) {
        return getStringAsTrimmedPrecision((this));
      } else if (this < 100000) {

        final precisionValues = (this / 1000).toString();//.toStringAsPrecision(2);
        var value = precisionValues.contains(".");
        if (value) {
          if (precisionValues.split(".")[1] == '0' ||
              precisionValues.split(".")[1] == '00') {
            return "${precisionValues.split(".")[0]}K";
          } else {
            return "${precisionValues}K";
          }
        } else {
          return "${precisionValues}K";
        }

        if (lastValue ?? false) {
          final precisionValues = (this / 1000).toString();//.toStringAsPrecision(2);
          var value = precisionValues.contains(".");
          if (value) {
            if (precisionValues.split(".")[1] == '0' ||
                precisionValues.split(".")[1] == '00') {
              return "${precisionValues.split(".")[0]}K";
            } else {
              return "${precisionValues}K";
            }
          } else {
            return "${precisionValues}K";
          }
        } else {
          // return "${getStringAsTrimmedPrecision((this / 1000),precision: 1)}K";
           return "${(this / 1000)}K";
        }
      }
      // else if (this < 10000000) {
      //   if (lastValue ?? false) {
      //     final precisionValues = (this / 100000).toStringAsPrecision(3);
      //
      //     var value = precisionValues.contains(".");
      //     if (value) {
      //       if (precisionValues.split(".")[1] == '0') {
      //         return "${precisionValues.split(".")[0]}L";
      //       } else {
      //         return "${precisionValues}L";
      //       }
      //     } else {
      //       return "${precisionValues}L";
      //     }
      //   } else {
      //     return "${getStringAsTrimmedPrecision((this / 100000))}L";
      //   }
      // }
      else if (this < 10000000) {
        return "${getStringAsTrimmedPrecision(this / 100000)}L";
      } else if (this < 10000000000) {
        return "${getStringAsTrimmedPrecision((this / 10000000))}Cr";
      } else if (this < 1000000000000) {
        return "${getStringAsTrimmedPrecision((this / 10000000000))}K Cr";
      } else {
        return "${getStringAsTrimmedPrecision((this / 1000000000000))}L Cr";
      }
    } catch (e) {
      rethrow;
    }
  }

  /// To format the number to string with commas
  String formatWithIndianComma() {
    if (this is int) {
      return NumberFormat(AppConstants.indianCommaFormat).format(this);
    } else {
      return NumberFormat(AppConstants.indianCommaFormatWithDecimal)
          .format((this * 100).round() / 100);
    }
  }

  /// To format the number to string with commas
  String formatWithIndianCommaRRR() {
    if (this is int) {
      return NumberFormat(AppConstants.indianCommaFormat).format(this);
    } else {
      return NumberFormat(AppConstants.indianCommaFormatWithDecimal)
          .format((this * 100) / 100);
    }
  }

  String formatWithIndianCommaAndRupeeSymbol() {
    return "${AppConstants.rupeeSymbol}${formatWithIndianComma()}";
  }

  String formatWithIndianTwoDecimalNumberFormat() {
    try {
      if (this < 0) {
        return "-${abs().formatToIndianHumanReadable()}";
      } else if (this == 0) {
        return '0';
      } else if (this < 10) {
        return toStringAsFixed(2);
      } else if (this < 1000) {
        return toStringAsFixed(2);
      } else if (this < 100000) {
        return "${(this / 1000).toStringAsFixed(2)}K";
      } else if (this < 10000000) {
        return "${(this / 100000).toStringAsFixed(2)}L";
      } else if (this < 10000000000) {
        return "${(this / 10000000).toStringAsFixed(2)}Cr";
      } else {
        return "${(this / 1000).toStringAsFixed(2)}k";
      }

      // if (this < 10) {
      //   return toStringAsFixed(2); // for single digit numbers, format with 2 decimal places
      // } else if (this < 10000000) {
      //   return "${(this / 100000).toStringAsFixed(2)}L"; // use L for lakhs with 2 decimal places
      // } else if (this >= 10000000) {
      //   return "${(this / 10000000).toStringAsFixed(2)}Cr"; // use Cr for crores with 2 decimal places
      // } else {
      //   return "${(this / 1000).toStringAsFixed(2)}k";
      // }
    } catch (e) {
      rethrow;
    }
  }

  String formatInPercentage() {
    try {
      if (this > 0) {
        return '${(this * 100).toStringAsFixed(2)}%';
      } else {
        return 'NA';
      }
    } catch (e) {
      return 'NA';
    }
  }

  String get toCurrencyFormat {
    var result = "";
    if (this < 100000) {
      result = NumberFormat.compact().format(this);
    } else {
      result = NumberFormat.compactCurrency(
        decimalDigits: 2,
        locale: 'en_IN',
        symbol: '',
      ).format(this);
    }
    return result;
  }

  /// Mutual Fund AUM formatter
  /// eg. 4000,00,00,000 -> 4000Cr
  String get toAum {
    var result = "";
    var amt = this;
    var tCr = 10000000000;
    var crore = 10000000;
    if (amt > tCr && amt / tCr > 0) {
      amt /= crore;
      return "${amt.round().toPriceFormatter()}Cr";
    }

    if (amt < 100000) {
      result = NumberFormat.compact().format(amt);
    } else {
      result = NumberFormat.compactCurrency(
        decimalDigits: 2,
        locale: 'en_IN',
        symbol: '',
      ).format(amt);
    }
    return result;
  }
}
