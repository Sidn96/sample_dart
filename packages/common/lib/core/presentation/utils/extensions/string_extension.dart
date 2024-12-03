extension StringExtension on String{
  String capitalizeFirstLetter() {
    if (isEmpty) {
      return this; // Return the input string as is if it's empty
    }
    return this[0].toUpperCase() + substring(1);
  }

  /// Capital first Character of each word
  /// eg. hello world -> Hello World
  String sentenceCase() {
    return split(' ').map((word) => word.capitalizeOnlyFirstLetter()).join(' ');
  }

  String capitalizeOnlyFirstLetter() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

}

extension StringExtension1 on String? {
  bool isNotNullNorEmpty() {
    return !isNullOrEmpty();
  }

  bool isNullOrEmpty() {
    return (this == null || this!.isEmpty);
  }

  String get removeAllCommas {
    if (isNotNullNorEmpty()) {
      return this!.replaceAll(",", "");
    }
    return "";
  }

  num convertToNum({num defaultValue = 0}) {
    if (isNullOrEmpty()) {
      return defaultValue;
    }
    try {
      return num.parse(this!);
    } catch (e) {
      return defaultValue;
    }
  }

  int convertToInt({int defaultValue = 0}) {
    if (isNullOrEmpty()) {
      return defaultValue;
    }
    try {
      return int.parse(this!);
    } catch (e) {
      return defaultValue;
    }
  }

  double get toDouble {
    if (isNullOrEmpty()) return 0.0;

    try {
      return double.parse(this!);
    } catch (e) {
      print("Error converting toDouble ${e.toString()}");
      return 0.0;
    }
  }

    int get toInt {
    if (isNullOrEmpty()) return 0;
    try {
      return int.parse(this!);
    } catch (e) {
      print("Error converting int ${e.toString()}");
      return 0;
    }
  }

  double get priceToDouble {
    if (isNullOrEmpty()) return 0.0;

    try {
      var v = removeAllCommas;
      return double.parse(v);
    } catch (e) {
      print("Error converting priceToDouble ${e.toString()}");
      return 0.0;
    }
  }

  int get priceToInt {
    if (isNullOrEmpty()) return 0;

    try {
      var v = removeAllCommas;

      // if (v.contains(".")) return double.parse(v).toInt();

      return int.parse(v);
    } catch (e) {
      print("Error converting $this priceToInt ${e.toString()}");
      return 0;
    }
  }

  ///mask pan card and only show last 4 characters
  String? maskPanCard() {
    try {
      int panCardLength = this?.length ?? 0;

      String maskedPan =
          'XXXXXX${this?.substring(panCardLength - 4, panCardLength)}';

      return maskedPan;
    } catch (e) {
      return e.toString();
    }
  }

  int ordinalToCardinalNumber({int defaultValue = 0}) {
    if (isNullOrEmpty()) return defaultValue;
    try {
      var aStr = this!.replaceAll(RegExp(r'[^0-9]'), '');
      if (aStr.isNullOrEmpty()) return defaultValue;
      return int.parse(aStr);
    } catch (e) {
      return defaultValue;
    }
  }

  ///This function takes an input of currency formatted String
  /// and return the number and String part
  /// eg. INPUT =>  30K, 4L, 4.5L, 2Cr
  /// OUTPUT =>  (30,K), (4,L), (4.5,L), (2,Cr)
  (double, String) get separateValueAndString {

    if(isNullOrEmpty()) return (0, "");

    // Regular expression to match the double value and suffix
    RegExp regExp = RegExp(r'(\d+(?:\.\d+)?)\s*(\D+)$');

    // Extracting matches
    Match? match = regExp.firstMatch(this!.trim());

    if (match != null && match.groupCount == 2) {
      // Group 1 is the numeric value, group 2 is the suffix
      double value = double.parse(match.group(1)!);
      String suffix = match.group(2)!;

      // Return a SeparatedValue object
      return (value, suffix);
    } else {
      // Handle invalid input or no match found
      // throw FormatException('Invalid format: $combinedString');
      return (0, "");
    }
  }

  String get convertCurrencyAbbreviation {
    if (isNullOrEmpty()) return "";
    return switch (this!.trim().toLowerCase()) {
      "k" => "Thousand",
      "l" => "Lakh",
      "cr" => "Crore",
      _ => ""
    };
  }
}
