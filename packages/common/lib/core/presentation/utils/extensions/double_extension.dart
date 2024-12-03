extension DoubleExtension on double? {

  String formatInPercentage({String defaultValue = "0"}) {
    try {
      if (this == null) return defaultValue;

      if(this! == 0.0) return defaultValue;

      return '${(this! * 100).toStringAsFixed(2)}%';
    } catch (e) {
      return defaultValue;
    }
  }

}
