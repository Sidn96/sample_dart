import 'package:flutter/material.dart';

extension IntExtensions on int? {
  /// validate given int is not null and returns given value if null.
  int validate({int value = 0}) {
    return this ?? value;
  }

  /// Leaves given height of space
  Widget get height => SizedBox(height: this?.toDouble());

  /// Leaves given width of space
  Widget get width => SizedBox(width: this?.toDouble());
}

extension IntExtensionsNew on int {
  String get toOrdinalNumbers {
    if (this >= 11 && this <= 13) return '${this}th';

    switch (this % 10) {
      case 1:
        return '${this}st';
      case 2:
        return '${this}nd';
      case 3:
        return '${this}rd';
      default:
        return '${this}th';
    }
  }

  String get to2DigitNumbers {
    return toString().padLeft(2,"0");
  }

  int get bytesToKB{
    return this ~/ 1024;
  }

  double get bytesToMB{
    return ((this / 1024) / 1024);
  }
}