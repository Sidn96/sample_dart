enum SchemeFilterTypeEnum {
  amc,
  performance;

  String get uiValue {
    return switch (this) {
      SchemeFilterTypeEnum.amc => "AMC",
      SchemeFilterTypeEnum.performance => "Performance",
    };
  }

  bool get isAmc => this == SchemeFilterTypeEnum.amc;

  bool get isPerformance => this == SchemeFilterTypeEnum.performance;

}