import 'package:common/core/domain/validator.dart';
import '../../../../../core/presentation/utils/riverpod_framework.dart';
part 'otp_notifier.g.dart';
@riverpod
class OTPValidation extends _$OTPValidation {
  final initialValue = -1;
  @override
  int build() => initialValue;

  ///validate Phone no.
  validateOTP(String value) {
    final newValue = Validator.otpValidation(value);
    state = newValue;
  }
}