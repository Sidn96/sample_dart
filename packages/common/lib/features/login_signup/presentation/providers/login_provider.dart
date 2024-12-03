import 'package:common/core/infrastructure/dtos/user_info_dto.dart';
import 'package:common/core/infrastructure/local_storage_data_source/secure_keys.dart';
import 'package:common/core/infrastructure/local_storage_data_source/secure_storage.dart';

import '../../../../../core/presentation/utils/app_string_constants.dart';
import '../../../../../core/presentation/utils/riverpod_framework.dart';
import '../../../../core/domain/usecase_error.dart';
import 'notifiers/login_signup_notifier.dart';

part 'login_provider.g.dart';

///to get DOB error strings
@riverpod
String getDOBErrorMsg(GetDOBErrorMsgRef ref) {
  int dobValidation = ref.watch(dOBValidationNotifierProvider);
  String? errorMsg;
  final map = {
    1: AppConstants.emptyDateMessage,
    2: AppConstants.dateFormatError,
    3: AppConstants.maxAgeMessage1,
    4: AppConstants.ageLessThan18,
    5: AppConstants.minmumAge,
  };

  errorMsg = map[dobValidation];
  return errorMsg ?? "";
}

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

@riverpod
Future<UserInfoDto?> getUserStoredData(ref) async {
  final userRaw = await SecureStorage().getPref(key: SecureKeys.memberInfo);
  if (userRaw != null && userRaw != "") {
    final userinfo = userInfoDtoFromJson(userRaw);
    return userinfo;
  } else {
    return null;
  }
}
