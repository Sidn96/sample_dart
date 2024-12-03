enum LoginFormEnum {
  eldercare("truepal-member"),
  nps("nps"),
  rc("rc-fc"),
  angel("truepal-partner"),
  health("health"),
  truefin("truefin"),
  savings("savings");

  final String value;

  const LoginFormEnum(this.value);
}

enum ProductEvent {
  eldercare("truepal-member"),
  nps("nps"),
  rc("rc-fc"),
  angel("truepal-partner"),
  health("health-insurance"),
  mf("mutual-fund"),
  truefin("truefin"),
  savings("savings");

  final String value;

  const ProductEvent(this.value);
}
