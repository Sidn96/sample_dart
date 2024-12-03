import 'package:common/core/infrastructure/dtos/send_mobile_otp_response_model_dto.dart';
import 'package:common/core/infrastructure/local_storage_data_source/login_local_data_source.dart';
import 'package:common/core/infrastructure/local_storage_data_source/secure_storage.dart';
import 'package:common/core/infrastructure/local_storage_data_source/secure_keys.dart';
import 'package:common/core/infrastructure/login_data_source/login_otp_remote_data_source.dart';
import 'package:common/core/infrastructure/network/network_info.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../dtos/validate_mobile_otp_response_model_dto.dart';

part 'login_repo.g.dart';

@Riverpod(keepAlive: true)
LoginRepo loginRepo(LoginRepoRef ref) {
  return LoginRepo(
    networkInfo: ref.watch(networkInfoProvider),
    remoteDataSource: ref.watch(loginRemoteDataSourceProvider),
    localDataSource: ref.watch(loginLocalDataSourceProvider),
  );
}

class LoginRepo {
  LoginRepo(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});

  final NetworkInfo networkInfo;
  final LoginRemoteDataSource remoteDataSource;
  final LoginLocalDataSource localDataSource;

  Future<ValidateMobileOTPFCResponseModelDto> validateMobileOtp(
      Map<String, dynamic> requestBody, String path) async {
    dynamic validateMobileOtpData;
    // if (await networkInfo.hasInternetConnection) {
    try {
      validateMobileOtpData =
          await remoteDataSource.validateMobileOtpApi(requestBody, path);
      print("Valid Token ${validateMobileOtpData.data.tokens?.accessToken}");
      //await localDataSource.cacheUserToken(validateMobileOtpData.data.tokens.accessToken);
      // await localDataSource.cacheRefreshToken(validateMobileOtpData.data.tokens.refreshToken);

      await SecureStorage().setPref(
          key: SecureKeys.accessToken,
          value: validateMobileOtpData.data.tokens.accessToken);
      await SecureStorage().setPref(
          key: SecureKeys.refreshToken,
          value: validateMobileOtpData.data.tokens.refreshToken);
      return validateMobileOtpData;
    } catch (e) {
      debugPrint("Repo Error: $e");
    }
    //  }
    return validateMobileOtpData;
  }

  Future<SendMobileOTPResponseModelDto?> sendOtpApi(
      Map<String, dynamic> requestBody, String path) async {
    // SendMobileOTPResponseModelDto sendMobileOtpResponseData;
    // if (await networkInfo.hasInternetConnection) {
    try {
     SendMobileOTPResponseModelDto sendMobileOtpResponseData =
          await remoteDataSource.sendMobileOtpApi(requestBody, path);

      return sendMobileOtpResponseData;
    } catch (e) {
      debugPrint("Repo Error: $e");
    }
    //  }
    return null;
  }
}
