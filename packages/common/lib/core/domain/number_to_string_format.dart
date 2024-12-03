import 'package:intl/intl.dart';

class NumberToStringFormat {
  NumberToStringFormat._();

  static String currencyNumberToString(num number,
      {bool prefixSymbol = true, int decimalValue = 2}) {
    String format(double n) {
      if (n == n.toInt()) {
        return n.toInt().toString();
      } else {
        return n.toStringAsFixed(decimalValue);
      }
    }

    var result = "";

    if (number >= 10000000) {
      result = "${format(number / 10000000)}Cr";
    } else if (number >= 100000) {
      result = "${format(number / 100000)}L";
    } else if (number >= 1000) {
      result = "${format(number / 1000)}K";
    } else {
      result = format(number.toDouble());
    }

    if (prefixSymbol) {
      return '₹$result';
    } else {
      return result.toString();
    }
  }

  static String currencyNumberToStringWithSymbol(num val) {
    var result = "";
    if (val < 100000) {
      result = NumberFormat.compact().format(val);
    } else {
      result = NumberFormat.compactCurrency(
        decimalDigits: 2,
        locale: 'en_IN',
        symbol: '',
      ).format(val);
    }
    return '₹$result';
  }
}
