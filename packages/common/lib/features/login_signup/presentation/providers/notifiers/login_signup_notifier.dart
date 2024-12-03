import '../../../../../core/presentation/utils/riverpod_framework.dart';
import '../validator.dart';

part 'login_signup_notifier.g.dart';

//TODO CONVERT error validation form INT to ENUM
@riverpod
class DOBValidationNotifier extends _$DOBValidationNotifier {
  final dobValue = -1;

  DOBValidationNotifier();

  @override
  int build() => dobValue;

  validateDateOfBirth(String? value) {
    if (value != null) {
      state = Validator.validateDateOfBirth(value);
      // CustomLogger.printLog("dobValue : $dobValue");
    } else {
      state = -1;
    }
  }
}

@riverpod
class FullNameValidateNotifier extends _$FullNameValidateNotifier {
  final initialValue = -1;

  FullNameValidateNotifier();

  @override
  int build() => initialValue;

  ///validate dob.
  validateFullName(String value) {
    final fullNameValidationValue = Validator.fullNameValidate(value);
    state = fullNameValidationValue;
  }
}


