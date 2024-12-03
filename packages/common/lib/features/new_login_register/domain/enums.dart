enum LoginRegisterStatesEnum {
  none(0),
  invalidMobNo(1),
  otpWillBeSendToMobileNumber(2),
  unableToSendOtp(3),
  // mandatoryCheckBoxPending(4),
  otpSent(4),
  resentOtp(5),
  otpError(6),
  otpFilled(7),
  loginRegisterSuccess(8);

  const LoginRegisterStatesEnum(this.value);

  final int value;
}
