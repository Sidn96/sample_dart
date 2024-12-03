import 'package:common/features/profile/presentation/common_imports.dart';

String getEmailObfuscation({required String value}) {
  if (value.isNotEmpty) {
    List<String> result = value.split("@");
    String resultedValue = result[0];
    String obfuscating =
        'xxxxxxxx${result[0].substring(resultedValue.length >= 3 ? 2 : resultedValue.length == 2 ? 1 : 0)}';
    return '$obfuscating@${result[1]}';
  }
  return "";
}

extension IndianRupeeFormatExtension on String {
  String toIndianRupeeFormat() {
    return NumberFormat.currency(locale: 'HI',decimalDigits: 0,symbol: "").format(int.tryParse(this));
  }
}
