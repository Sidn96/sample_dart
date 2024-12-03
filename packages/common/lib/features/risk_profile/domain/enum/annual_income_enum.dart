abstract class CommonEnumFunction {
  String getApiKey();

  String getValue();
}

////Todo : in optimization
enum AnnualIncomeEnum implements CommonEnumFunction {
  v_10L,
  v_10_25L,
  v_25L;

  static String getHeaderLabel(String value) {
    switch (value) {}
    return "null";
  }

  String getHeaderLabel1() {
    return switch (this) { v_10_25L => "", _ => "default" };
  }

  @override
  String getApiKey() {
    return "null";
  }

  @override
  String getValue() {
    return "null";
  }
}
//
// void test() {
//   var b = AnnualIncomeEnum.getHeaderLabel(AnnualIncomeEnum.v_10_25L.toString());
//   var a = AnnualIncomeEnum.v_10_25L;
//   var c = a.getHeaderLabel1();
// }
