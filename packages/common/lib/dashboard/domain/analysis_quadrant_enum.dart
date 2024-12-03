
enum AnalysisQuadrantEnum{
  ideal("4"),
  imperfect("3"),
  undesirable("2"),
  concerning("1"),
  none("0");
  final String sortIndex;

  const AnalysisQuadrantEnum(this.sortIndex);

  static AnalysisQuadrantEnum  getEnumFromApi(String value) {
    return switch (value) {
      "Ideal" => ideal,
      "Imperfect" => imperfect,
      "Undesirable" => undesirable,
      "Concerning" => concerning,
      _ => none,
    };
  }

  String get uiValue => switch (this) {
    ideal => "High on performance Low on risk",
    imperfect => "High on performance High on risk",
    undesirable => "Low on performance Low on risk",
    concerning => "Low on performance High on risk",
    none => "",
  };

  String get uiTitle => switch (this) {
    ideal => "Ideal",
    imperfect => "Imperfect",
    undesirable => "Undesirable",
    concerning => "Concerning",
    none => "",
  };
}