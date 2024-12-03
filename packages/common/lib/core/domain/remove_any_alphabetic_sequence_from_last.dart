

class RemoveLastSequence {
  RemoveLastSequence._();

  static String removeLyFromLast(String text) {
    if (text.toLowerCase().contains("ly")) {
      return text.toLowerCase().split("ly").first.toLowerCase();
    } else {
      return text.toLowerCase();
    }
  }
}
