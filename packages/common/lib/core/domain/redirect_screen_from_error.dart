class RedirectScreenFromError {
  RedirectScreenFromError._();

  static int getThreeDigitCode(String exception) {
    String mainException;
    if (exception.toLowerCase().contains("code")) {
      mainException = exception.split("code").last;
    } else {
      mainException = exception;
    }
    RegExp regExp = RegExp(
      r"\b\d{3}\b",
      caseSensitive: false,
      multiLine: false,
    );

    Iterable<Match> matches = regExp.allMatches(mainException);

    for (Match match in matches) {
      if (match.group(0) != null) {
        if (int.parse(match.group(0)!) >= 400 &&
            int.parse(match.group(0)!) <= 550) {
          return int.parse(match.group(0)!);
        }
      }
    }
    return -1;
  }
}
