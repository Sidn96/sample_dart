import 'package:common/core/presentation/utils/riverpod_framework.dart';

import '../../../domain/usecase_error.dart';
import 'login_notifiers.dart';
import 'otp_notifier.dart';

part 'phone_num_validator_notifier.g.dart';

///to get phone no. error strings
@riverpod
String getPhoneErrorMsg(GetPhoneErrorMsgRef ref) {
  final phoneValidationValue = ref.watch(phoneNoValidationNotifierProvider);

  return phoneValidationValue == 1
      ? AppUseCasesErrors.phoneNotEmpty
      : phoneValidationValue == 2
          ? AppUseCasesErrors.enterProperNo
          : phoneValidationValue == 0
              ? AppUseCasesErrors.getAnOTP
              : "";
}

@riverpod
class IsLoading extends _$IsLoading {
  @override
  bool build() {
    return false;
  }

  void setLoading(bool value) {
    state = value;
  }
}

///to show OTP field
@riverpod
bool toShowOTPField(ToShowOTPFieldRef ref) {
  final sendOTPResponse = ref.watch(sendMobileOtpNotifierProvider);
  print("toShowOTPField provider status: ${sendOTPResponse.value?.status}");
  if (sendOTPResponse.value?.status == 200) {
    return true;
  }
  return false;
}

///to get OTP error strings
@riverpod
String getOTPVerifyMsg(GetOTPVerifyMsgRef ref) {
  String? error;
  //final validateOtpResponse = ref.watch(validateMobileOtpNotifierProvider);
  final otpValue = ref.watch(oTPValidationNotifierProvider);
  if (otpValue == 1) {
    error = AppUseCasesErrors.otpNotEmpty;
    return error;
  }
  if (otpValue == 2) {
    error = AppUseCasesErrors.enterValidOTP;
    return error;
  }

  return error ?? "";
}

///to change resend text color
@riverpod
bool changeResendColor(ChangeResendColorRef ref) {
  final timerValue = ref.watch(resendOTPTimerNotifierProvider);
  return timerValue == 0 ? true : false;
}

// success validate for ask our experts flow on validate mobile otp
@riverpod
bool loginSuccess(LoginSuccessRef ref) {
  final validateMobileOTPProvider =
      ref.watch(validateMobileOtpNotifierProvider);
  return validateMobileOTPProvider.value?.success ?? false;
  //
}

// success validate for 1st free consultant & subscription flow on validate mobile otp
@riverpod
bool loginFCSuccess(LoginFCSuccessRef ref) {
  final validateMobileOTPProvider =
      ref.watch(validateMobileOtpNotifierProvider);
  return validateMobileOTPProvider.value?.success ?? false;
  //
}

///to get phone no. error strings
@riverpod
String getFullNameErrorMsg(GetFullNameErrorMsgRef ref) {
  final fullNameValidationValue = ref.watch(fullNameValidateNotifierProvider);
  return fullNameValidationValue == 1
      ? AppUseCasesErrors.fullNameNotEmpty
      : fullNameValidationValue == 2
          ? AppUseCasesErrors.enterProperName
          : fullNameValidationValue == 0
              ? ""
              : "";
}
