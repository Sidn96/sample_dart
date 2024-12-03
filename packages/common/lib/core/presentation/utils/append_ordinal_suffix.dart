
/// Add 1st, 2nd, 3rd, 4th ...
/// on numbers
String appendOrdinalSuffix(int number) {
  if (number == 0) {
    return '0';
  }

  int lastDigit = number % 10;
  int lastTwoDigits = number % 100;

  String suffix;
  if (lastTwoDigits >= 11 && lastTwoDigits <= 13) {
    suffix = 'th';
  } else {
    switch (lastDigit) {
      case 1:
        suffix = 'st';
        break;
      case 2:
        suffix = 'nd';
        break;
      case 3:
        suffix = 'rd';
        break;
      default:
        suffix = 'th';
    }
  }

  return '$number$suffix';
}