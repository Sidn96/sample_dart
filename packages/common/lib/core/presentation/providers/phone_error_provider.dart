
import 'package:common/core/presentation/providers/notifiers/login_notifiers.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';

import '../utils/app_string_constants.dart';


part 'phone_error_provider.g.dart';

@riverpod
String getPhonenumError(GetPhonenumErrorRef ref) {
  final phoneValidationValue = ref.watch(phoneNoValidationNotifierProvider);
  return phoneValidationValue == 1
      ? AppConstants.phoneNotEmpty
      : phoneValidationValue == 2
      ? AppConstants.enterProperNo
      : phoneValidationValue == 0
      ? AppConstants.getanOTP
      : "";
}