List<String> exceptions = ['and'];

extension StringCleaner on String {
  String removeSpecialChars() {
    return replaceAll('\n', '').replaceAll('\t', '');
  }
}

extension TitleCase on String {
  String capitalizeFirstCharOfString() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String maskLastDigits({int visibleDigits = 4}) {
    // Ensure the string has more characters than the visible digits
    if (length <= visibleDigits) {
      return this;
    }

    // Generate a masked string with all characters except the last few digits
    String maskedPart = '*' * (length - visibleDigits);
    String visiblePart = substring(length - visibleDigits);
    return '$maskedPart$visiblePart';
  }

  String toTitleCase() {
    return toLowerCase().replaceAllMapped(
        RegExp(
            r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+'),
        (Match match) {
      if (exceptions.contains(match[0])) {
        return match[0] ?? "-";
      }
      return "${match[0]?[0].toUpperCase()}${match[0]?.substring(1).toLowerCase()}";
    }).replaceAll(RegExp(r'[|]+'), ' ');
  }

//preserves existing capital letters
  String toTitleCase2() {
    return split(' ').map((word) {
      if (word.isNotEmpty) {
        // Capitalize the first letter, but don't touch other capital letters
        return word[0].toUpperCase() + word.substring(1);
      }
      return word;
    }).join(' ');
  }
}
