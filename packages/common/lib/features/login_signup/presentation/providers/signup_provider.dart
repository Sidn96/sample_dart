import 'package:common/core/infrastructure/local_storage_data_source/secure_keys.dart';
import 'package:common/core/infrastructure/local_storage_data_source/secure_storage.dart';
import 'package:common/core/presentation/utils/global_loading_indicator.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/features/login_signup/domain/login_request_dto.dart';
import 'package:common/features/login_signup/domain/login_response_dto.dart';
import 'package:common/features/login_signup/domain/send_otp_request_dto.dart';
import 'package:common/features/login_signup/domain/sendotp_response_body_dto.dart';
import 'package:common/features/login_signup/domain/signup_request_dto.dart';
import 'package:common/features/login_signup/domain/signup_response_dto.dart';
import 'package:common/features/login_signup/infrastructure/repo/login_repo.dart';
import 'package:common/features/login_signup/presentation/providers/notifiers/new_login_notifiers.dart';
import '../../../profile/presentation/common_imports.dart';

part 'signup_provider.g.dart';

@riverpod
class SignUpNotifier extends _$SignUpNotifier {
  @override
  FutureOr<SignUpResponseBody?> build() {
    return null;
  }

  Future<bool> signupProcess(LoginFormEnum source, String otp, String fullName,
      String mobileNumber, String emailId,
      {Function(String?)? otpInvalid}) async {
    try {
      final loginSignHandler = ref.watch(loginSignRepoProvider);
      SignUpRequestBody signUpRequestBody = SignUpRequestBody(
          otp: otp,
          countryCode: "+91",
          source: source,
          fullName: fullName,
          contactNo: mobileNumber,
          personalEmail: emailId);
      final result = await loginSignHandler.signUpRepo(signUpRequestBody);
      print("Response status: ${result.status}");

      state = AsyncValue.data(result);
      if (result.status == 200) {
        ref.watch(userNameProvider.notifier).update(result.data?.fullName);
        await SecureStorage()
            .setPref(key: SecureKeys.phoneNumber, value: mobileNumber);
        await SecureStorage().setPref(
            key: SecureKeys.accessToken,
            value: result.data?.tokens?.accessToken ?? "");
        await SecureStorage().setPref(
            key: SecureKeys.refreshToken,
            value: result.data?.tokens?.refreshToken ?? "");
        return true;
      } else {
        otpInvalid?.call(result.error);
        return false;
      }
    } catch (e) {
      print("validateOtp error $e");
      return false;
    }
  }
}

@Riverpod(keepAlive: false)
class SendOTPNotifier extends _$SendOTPNotifier {
  @override
  FutureOr<SendOtpResponseBodyDto?> build() {
    return null;
  }

  Future<SendOtpResponseBodyDto> sendSignUpOTP(LoginFormEnum source,
      String mobile,
      {Function(String?)? userAlreadyExist}) async {
    dynamic result;
    try {
      final sendOtpHandler = ref.watch(loginSignRepoProvider);
      SendOtpRequestBodyDto requestBodyDto = SendOtpRequestBodyDto(
          reference: mobile,
          countryCode: "+91",
          referenceType: "contactno",
          source: source);
      final result = await sendOtpHandler.sendOtpRepo(requestBodyDto);
      if (result.success == true) {
        print("Otp success");
        return result;
      } else {
        userAlreadyExist?.call(result.error);
      }
    } catch (e) {
      print("sendOtp error $e");
      rethrow;
    }
    return result;
  }
}

@riverpod
class CommonSignIn extends _$CommonSignIn {
  @override
  FutureOr<LoginResponseBodyDto?> build() {
    return null;
  }

  Future<bool> sigIn(LoginFormEnum source, String otp, String mobileNumber, bool
  froRegister, String appName,
      {Function(String?)? noRecordFound}) async {
    try {
      final signinHandler = ref.watch(loginSignRepoProvider);
      LoginRequestBodyDto requestBodyDto = LoginRequestBodyDto(
        source: source,
        countryCode: "+91",
        otp: otp,
        emailOrPhone: mobileNumber,
      );
      final signinResponse =
      await signinHandler.loginRepo(requestBodyDto, froRegister, appName);
      if (signinResponse.status == 200) {
        await SecureStorage()
            .setPref(key: SecureKeys.phoneNumber, value: mobileNumber);
        await SecureStorage().setPref(
            key: SecureKeys.accessToken,
            value: signinResponse.data?.tokens?.accessToken ?? "");
        await SecureStorage().setPref(
            key: SecureKeys.refreshToken,
            value: signinResponse.data?.tokens?.refreshToken ?? "");
        return true;
      } else if (signinResponse.status == 404) {
        noRecordFound?.call(signinResponse.error);
        return false;
      } else {
        noRecordFound?.call(signinResponse.error);
        return false;
      }
    } catch (e) {
      print("sign error $e");
      hideProgressBar(ref);
      return false;
    }
  }
}
