import 'package:common/features/profile/presentation/common_imports.dart';

part 'active_form_provider.g.dart';

@riverpod
class ActiveFormProvider extends _$ActiveFormProvider {
  @override
  int build() {
    return 0;
  }

  changeActiveIndex(int index) {
    state = index;
  }
}

@riverpod
class ShowSendOtp extends _$ShowSendOtp {
  @override
  bool build() {
    return false;
  }

  changeActiveState(bool val) {
    state = val;
  }
}

@riverpod
class EnableCtaButton extends _$EnableCtaButton {
  @override
  bool build() {
    return false;
  }

  changeActiveState(bool val) {
    state = val;
  }
}

@riverpod
class EnableCtaButtonText extends _$EnableCtaButtonText {
  @override
  String build() {
    return "Next";
  }

  changeActiveState(String val) {
    state = val;
  }
}

// You will get an OTP on this no.

@riverpod
class MobileNumberChecker extends _$MobileNumberChecker {
  @override
  String build() {
    return "";
  }

  changeActiveState(String val) {
    state = val;
  }

  bool mobileRegex(String mobileNum) {
    String pattern = r'^(?!(\d)\1{4,})([6789]\d{9})$';
    RegExp regExp = RegExp(pattern);
    if (mobileNum.isEmpty) {
      state = 'Mobile Number Cannot Be Empty';
      return false;
    } else if (!regExp.hasMatch(mobileNum)) {
      state = 'Enter Valid Mobile Number';
      return false;
    } else {
      state = AppConstants.getOtpOnNumMessage;
      return true;
    }
  }
}

@riverpod
class EmailValidationNotifier extends _$EmailValidationNotifier {
  @override
  String? build() {
    return null;
  }

  changeActiveState(String val) {
    state = val;
  }
}


@riverpod
class AlreadyUserNotifier extends _$AlreadyUserNotifier {
  @override
  String? build() {
    return null;
  }

  alreadyUserMessage(String value){
    state = value;
  }
}

@riverpod
class SendOtpErrorNotifier extends _$SendOtpErrorNotifier {
  @override
  String? build() {
    return null;
  }

  sendOtpErrorMessage(String value){
    state = value;
  }
}
