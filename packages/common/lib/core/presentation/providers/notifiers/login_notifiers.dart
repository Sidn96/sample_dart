import 'package:common/core/domain/validator.dart';
import 'package:common/core/infrastructure/dtos/send_mobile_otp_response_model_dto.dart';
import 'package:common/core/infrastructure/local_storage_data_source/secure_keys.dart';
import 'package:common/core/infrastructure/local_storage_data_source/secure_storage.dart';
import 'package:common/core/presentation/providers/notifiers/phone_num_validator_notifier.dart';
import 'package:common/core/presentation/utils/log_print.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:flutter/material.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:common/core/presentation/components/otp_text_field.dart';

import '../../../infrastructure/dtos/validate_mobile_otp_response_model_dto.dart';
import '../../../infrastructure/repos/login_repo.dart';
import 'otp_notifier.dart';

part 'login_notifiers.g.dart';

/// phone no. validation notifier



@riverpod
class PhoneNoValidationNotifier extends _$PhoneNoValidationNotifier {
  final initialValue = -1;

  PhoneNoValidationNotifier();

  @override
  int build() => initialValue;

  ///validate Phone no.
  validatePhoneNo(String value) {
    final newValue = Validator.phoneNoValidate(value);
    state = newValue;
  }

  resetValue(int value) {
    state = value;
  }
}

@riverpod
class UnauthorizedNotifier extends _$UnauthorizedNotifier {
  @override
  String? build() {
    return null;
  }
  unAuthorize(String value) {
    state = value;
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

/// phone no. validation notifier
@riverpod
class DOBValidationNotifier extends _$DOBValidationNotifier {
  final dobValue = 0;

  DOBValidationNotifier();

  @override
  int build() => dobValue;

  ///set new int value
  void setNewIntValue(int value) {
    state = value;
  }

  ///validate dob.
  validateDOB(DateTime value) {
    final dobValue = Validator.ageValidation(value);
    ref.watch(dOBValidationNotifierProvider.notifier).setNewIntValue(dobValue);
  }

  FutureOr<int> validateDateOfBirth(String dob) {
    final result = Validator.validateDateOfBirth(dob);
    state = result;
    return Future.value(result);
  }

  FutureOr<int> validateDobAndDoj({required String dob, required String doj}) {
    final result = Validator.validateDojWithDob(dob: dob, doj: doj);
    state = result;
    return Future.value(result);
  }

  int getState() => state;
}

@riverpod
class CheckTermsAndConditionNotifier extends _$CheckTermsAndConditionNotifier {
  final boolValue = true;

  CheckTermsAndConditionNotifier();

  @override
  bool build() => boolValue;

  changeCheckBoxValue(bool value) {
    state = value;
  }
}

@riverpod
class CheckWhatsAppNotifier extends _$CheckWhatsAppNotifier {
  final boolValue = true;

  CheckWhatsAppNotifier();

  @override
  bool build() => boolValue;

  changeCheckBoxValue(bool value) {
    state = value;
  }
}

@riverpod
class CheckRememberMeNotifier extends _$CheckRememberMeNotifier {
  final boolValue = true;

  CheckRememberMeNotifier();

  @override
  bool build() => boolValue;

  changeCheckBoxValue(bool value) {
    state = value;
  }
}

@riverpod
class FatcaCheckNotifier extends _$FatcaCheckNotifier {
  final value = true;

  FatcaCheckNotifier();

  @override
  bool build() => value;

  changeCheckBoxValue(bool value) {
    state = value;
  }
}

/// login notifier
@Riverpod(keepAlive: false)
class SendMobileOtpNotifier extends _$SendMobileOtpNotifier {
  TextEditingController? phoneNoController;

  TextEditingController? fullNameController;
  OtpFieldController? otpFieldController;
  AnimationController? otpMobileClockController;
  String otpField = "";
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  FutureOr<SendMobileOTPResponseModelDto?> build() async {
    phoneNoController = TextEditingController();
    fullNameController = TextEditingController();
    otpFieldController = OtpFieldController();
    return null;
  }

  reset() {
    state = const AsyncValue.data(null);
  }

  sendMobileOtpApi(String source, String path) async {
    try {
      String? trimmedMob = phoneNoController?.text.trim();

      final loginRepo = ref.watch(loginRepoProvider);

      Map<String, dynamic> requestBody = {
        "source": source,
        "reference": trimmedMob,
        "referenceType": "contactno",
        "countryCode": "+91"
      };

      //for dynamic request body;
      //requestBody.addEntries([const MapEntry("source", "")]);
      ref.read(isLoadingProvider.notifier).setLoading(true);
      state = const AsyncLoading();
      final sendOtp = await loginRepo.sendOtpApi(requestBody, path);
      state = AsyncValue.data(sendOtp);

      if (sendOtp?.success ?? false) {
        ref.read(isLoadingProvider.notifier).setLoading(false);
        ref.read(resendOTPTimerNotifierProvider.notifier).startOTPTimer();
        // ref.read(rRRPageViewNotifierProvider.notifier).scrollDown();
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      logPrint("sendOtp error $e");
      rethrow;
    }
  }
}

//validate otp notifier for first free consult & subscription flow
@riverpod
class ValidateMobileOtpNotifier extends _$ValidateMobileOtpNotifier {
  @override
  FutureOr<ValidateMobileOTPFCResponseModelDto?> build() async {
    return null;
  }

  ///to validate mobile otp
  Future<bool> validateMobileOTPForFC(
      String source, String path, LoginFormEnum loginFormEnum, { Function(String?)? otpInvalid}) async {
    state = const AsyncLoading();
    try {
      final phoneNo = ref
          .read(sendMobileOtpNotifierProvider.notifier)
          .phoneNoController!
          .text
          .trim();

      /*    final getAccessToken = await ref
          .read(getCacheServiceProvider)
          .getKey(CacheServiceKeys.rcAccessToken);*/

      final fullNameText = ref
          .read(sendMobileOtpNotifierProvider.notifier)
          .fullNameController!
          .text;

      final loginRepo = ref.watch(loginRepoProvider);
      Map<String, dynamic> requestBody = {};
      switch (loginFormEnum) {
        case LoginFormEnum.eldercare:
          requestBody = {
            "source": source,
            "reference": phoneNo,
            "otp": ref.read(sendMobileOtpNotifierProvider.notifier).otpField,
            "countryCode": "+91"
          };
          break;
        case LoginFormEnum.health:
        case LoginFormEnum.savings:
          requestBody = {
            "source": source,
            "contactNo": phoneNo,
            "otp": ref.read(sendMobileOtpNotifierProvider.notifier).otpField,
            "countryCode": "+91",
            "isWhatsappCommEnabled": true
          };
          break;
        case LoginFormEnum.nps:
        case LoginFormEnum.truefin:
          requestBody = {
            "source": source,
            "contactNo": phoneNo,
            "otp": ref.read(sendMobileOtpNotifierProvider.notifier).otpField,
            "countryCode": "+91",
            "isWhatsappCommEnabled": true,
          };
          break;
        case LoginFormEnum.rc:
          requestBody = {
            "source": source,
            "reference": phoneNo,
            "otp": ref.read(sendMobileOtpNotifierProvider.notifier).otpField,
            "countryCode": "+91",
            "isWhatsappCommEnabled": true,
            "fullName": fullNameText,
          };
          break;
        case LoginFormEnum.angel:
          requestBody = {
            "otp": ref.read(sendMobileOtpNotifierProvider.notifier).otpField,
            "emailOrPhone": phoneNo,
            "source": source,
            "countryCode": "+91",
          };
          break;
      }

      final validateOtp = await loginRepo.validateMobileOtp(requestBody, path);
      state = AsyncValue.data(validateOtp);
      print("${validateOtp..error}");
      if (state.value?.status == 200) {
        await SecureStorage()
            .setPref(key: SecureKeys.phoneNumber, value: phoneNo);
        return true;
        /*  ref.read(getCacheServiceProvider).setKey(CacheServiceKeys.rcAccessToken,
            validateOtp.data.tokens?.accessToken ?? "");*/
      }
      else {
        otpInvalid?.call(validateOtp.error);
        return false;
      }
    } catch (e) {
      print("validateOtp error $e");
      return false;
    }
  }
}
