import 'package:intl/intl.dart';

var emalFormat = NumberFormat('#,##,###.##');
var formatter = NumberFormat('#,##,###.##');
var fourDecimalNumberFormatter = NumberFormat('#,##,##0.0000');
var oneDecimalNumberFormatter = NumberFormat('#,##,##0.0');
var percentageFormatter = NumberFormat('##.##%');
var sevenDecimalNumberFormatter = NumberFormat('#,##,##0.0000000');
var threeDecimalNumberFormatter = NumberFormat('#,##,##0.000');
var twoDecimalNumberFormatter = NumberFormat('#,##,###.00');

var zeroDecimalNumberFormatter = NumberFormat('#,##,###');

extension DoubleExtension on double? {
  double get to2Decimal {
    if (this == null) return 0.0;
    return (this! * 100).round() / 100;
  }

  double get to4Decimal {
    if (this == null) return 0.0;
    return (this! * 10000).round() / 10000;
  }
}

extension EmailHide on String {
  toEmailHidder() {
    return emalFormat.format(this);
  }
}

extension ExtOnNum on num {
  String toformatNumberToLacThousand({bool addSpace = false}) {
    final indianFormat = NumberFormat.compact(locale: 'en_IN');
    String formattedNumber = indianFormat.format(this);

    // Custom suffix for K (thousands), L (lakhs), Cr (crores)
    if (formattedNumber.contains('T')) {
      formattedNumber =
          formattedNumber.replaceAll('T', addSpace ? ' K' : 'K'); // Thousand
    } else if (formattedNumber.contains('L')) {
      formattedNumber =
          formattedNumber.replaceAll('L', addSpace ? ' L' : 'L'); // Lakh
    } else if (formattedNumber.contains('Cr')) {
      formattedNumber =
          formattedNumber.replaceAll('Cr', addSpace ? ' Cr' : 'Cr'); // Crore
    }

    return formattedNumber;
  }

  String toGainLossPercentageFormatter() {
    var nf = NumberFormat.decimalPercentPattern(
      locale: "hi",
      decimalDigits: 2,
    );
    if (this > 0) {
      return "+${nf.format(this / 100)}";
    }
    return nf.format(this / 100);
  }

  String toPriceFormatter() {
    return formatter.format(this);
  }

  toPriceFormatterWithDecimal(int decimalDigits) {
    switch (decimalDigits) {
      case 0:
        return zeroDecimalNumberFormatter.format(this);
      case 1:
        throw oneDecimalNumberFormatter.format(this);
      case 2:
        return twoDecimalNumberFormatter.format(this);
      case 3:
        return threeDecimalNumberFormatter.format(this);
      case 4:
        return fourDecimalNumberFormatter.format(this);
      case 7:
        return sevenDecimalNumberFormatter.format(this);
      default:
        return formatter.format(this);
    }
  }
}
