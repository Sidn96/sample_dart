import 'package:common/core/infrastructure/local_storage_data_source/secure_keys.dart';
import 'package:common/core/infrastructure/local_storage_data_source/secure_storage.dart';
import 'package:common/core/infrastructure/network/network_info.dart';
import 'package:common/features/login_signup/domain/login_request_dto.dart';
import 'package:common/features/login_signup/domain/login_response_dto.dart';
import 'package:common/features/login_signup/domain/send_otp_request_dto.dart';
import 'package:common/features/login_signup/domain/sendotp_response_body_dto.dart';
import 'package:common/features/login_signup/domain/signup_request_dto.dart';
import 'package:common/features/login_signup/domain/signup_response_dto.dart';
import 'package:common/features/login_signup/infrastructure/data_sources/login_remote_data_source.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/cupertino.dart';

part 'login_repo.g.dart';

@Riverpod(keepAlive: true)
LoginSignRepo loginSignRepo(LoginSignRepoRef ref) {
  return LoginSignRepo(
      loginSignUpDataSource: ref.watch(loginSignUpDataSourceProvider),
      networkInfo: ref.watch(networkInfoProvider));
}

class LoginSignRepo {
  LoginSignRepo(
      {required this.loginSignUpDataSource, required this.networkInfo});

  final NetworkInfo networkInfo;
  final LoginSignUpDataSource loginSignUpDataSource;

  Future<LoginResponseBodyDto> loginRepo(LoginRequestBodyDto requestBodyDto,
      bool froRegister, String appName) async {
    dynamic loginData;
    try {
      loginData =
      await loginSignUpDataSource.login(requestBodyDto, froRegister,
          appName);

      await SecureStorage().setPref(
          key: SecureKeys.accessToken,
          value: loginData.data.tokens.accessToken);

      await SecureStorage().setPref(
          key: SecureKeys.refreshToken,
          value: loginData.data.tokens.refreshToken);

      return loginData;
    } catch (e) {
      debugPrint("Repo Error: $e");
    }
    return loginData;
  }

  Future<SendOtpResponseBodyDto> sendOtpRepo(
      SendOtpRequestBodyDto requestBody) async {
    dynamic sendOtpData;
    try {
      sendOtpData = await loginSignUpDataSource.sendMobileOtp(requestBody);
      return sendOtpData;
    } catch (e) {
      debugPrint("Repo Error: $e");
    }
    return sendOtpData;
  }

  Future<SignUpResponseBody> signUpRepo(
      SignUpRequestBody signUpRequestBody) async {
    dynamic signUpData;
    try {
      signUpData = await loginSignUpDataSource.signUp(signUpRequestBody);
      return signUpData;
    } catch (e) {
      debugPrint("Repo Error: $e");
    }
    return signUpData;
  }
}
