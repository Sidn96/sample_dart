import 'dart:async';


import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/validator.dart';

part 'otp_notifier.g.dart';

/// otp no. validation notifier
@riverpod
class OTPValidationNotifier extends _$OTPValidationNotifier {
  final initialValue = -1;

  OTPValidationNotifier();

  @override
  int build() => initialValue;

  ///validate Phone no.
  validateOTP(String value) {
    final newValue = Validator.otpValidation(value);
    state = newValue;
  }
}

///resend otp timer provider
@riverpod
class ResendOTPTimerNotifier extends _$ResendOTPTimerNotifier {
  int initialValue = 30;
  Timer? timer;

  ResendOTPTimerNotifier();

  @override
  int build() => initialValue;

  void startOTPTimer() {
    if(timer != null && timer!.isActive){
      timer?.cancel();
    }
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (state <= 0) {
        t.cancel();
      } else {
        state = initialValue--;
      }
    });
  }

  void resetOTPTimer() {
    if(timer != null && timer!.isActive){
      timer?.cancel();
    }
    initialValue = 30;
    state = 30;
  }

}
