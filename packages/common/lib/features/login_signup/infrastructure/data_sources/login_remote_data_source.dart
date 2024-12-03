import 'dart:io';

import 'package:common/core/infrastructure/dtos/user_info_dto.dart';
import 'package:common/core/infrastructure/error/app_exception.dart';
import 'package:common/core/infrastructure/local_storage_data_source/secure_keys.dart';
import 'package:common/core/infrastructure/local_storage_data_source/secure_storage.dart';
import 'package:common/core/infrastructure/network/main_api/api_callers/api_facade.dart';
import 'package:common/core/presentation/utils/app_info.dart';
import 'package:common/features/login_signup/domain/login_request_dto.dart';
import 'package:common/features/login_signup/domain/login_response_dto.dart';
import 'package:common/features/login_signup/domain/send_otp_request_dto.dart';
import 'package:common/features/login_signup/domain/sendotp_response_body_dto.dart';
import 'package:common/features/login_signup/domain/signup_request_dto.dart';
import 'package:common/features/login_signup/domain/signup_response_dto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/presentation/utils/riverpod_framework.dart';

part 'login_remote_data_source.g.dart';

@Riverpod(keepAlive: true)
LoginSignUpDataSource loginSignUpDataSource(LoginSignUpDataSourceRef ref) {
  return LoginSignUpDataSource(
    ref,
    api: ref.watch(apiFacadeProvider),
  );
}

class LoginSignUpDataSource {
  final LoginSignUpDataSourceRef ref;
  final ApiFacade api;
  String otpPath = "/member/otp/send";
  String loginUrl = "/member/login";

  String loginRegister = "/member/login-register";

  String signupUrl = "/member/register";
  String memberInfoUrl = "/member/info";

  LoginSignUpDataSource(this.ref, {required this.api});

  Future<UserInfoDto> getMemberInfo() async {
    debugPrint("**getMemberInfo");
    try {
      final response = await api.getData(path: memberInfoUrl, sendToken: true);
      if (response.data != null) {
        UserInfoDto newInfo = UserInfoDto.fromJson(response.data);
        SecureStorage().setPref(
            key: SecureKeys.memberInfo, value: userInfoDtoToJson(newInfo));
        return newInfo;
      } else {
        return UserInfoDto.fromJson(response.data);
      }
    } on DioException catch (e) {
      return UserInfoDto.fromJson(e.response?.data);
    } catch (e) {
      throw ServerException(
        type: ServerExceptionType.notFound,
        message: '$e',
      );
    }
  }

  Future<LoginResponseBodyDto> login(LoginRequestBodyDto requestBodyDto,
      bool forRegsiter, String appName) async {
    try {

      late Map<String, String> loginHeader;
      String? partnerRef = await SecureStorage().getPref(key: 'partnerRef');

      if(kIsWeb==false){
        final deviceInfoPlugin = DeviceInfoPlugin();
        final appVersion = await AppInfo.getAppInfo();
        if (Platform.isIOS) {
          IosDeviceInfo deviceInfo = await deviceInfoPlugin.iosInfo;
          loginHeader = {
            "devicemodel": "${deviceInfo.model} ${deviceInfo.name} "
                "${deviceInfo.systemVersion}",
            "devicevendor": "${deviceInfo.utsname.sysname}",
            "os": "IOS",
            "appversion": appVersion,
            "udid": "${deviceInfo.identifierForVendor}",
            "appname": appName,
            "osversion" : "IOS ${deviceInfo.systemName}",
            if (partnerRef != null) "partnerRef": partnerRef,

          };
        } else {
          AndroidDeviceInfo deviceInfo = await deviceInfoPlugin.androidInfo;
          loginHeader = {
            "devicemodel": "${deviceInfo.model} ${deviceInfo.brand}"
                "${deviceInfo.device}",
            "devicevendor": deviceInfo.manufacturer,
            "os": "Android",
            "appversion": appVersion,
            "udid": deviceInfo.id,
            "appname": appName,
            "osversion" : "Android ${deviceInfo.version.release}",
            if (partnerRef != null) "partnerRef": partnerRef,

          };
        }
      }else{
         loginHeader = {
            if (partnerRef != null) "partnerRef": partnerRef,
          };
      }


      final body = forRegsiter
          ? {
              "otp": requestBodyDto.otp,
              "contactNo": requestBodyDto.emailOrPhone,
              "source": requestBodyDto.source?.value,
              "countryCode": "+91",
              "isWhatsappCommEnabled": false
            }
          : requestBodyDto.toJson();

      final response = await api.postData(
          path: forRegsiter ? loginRegister : loginUrl,
          data: body,
          options: Options(
            headers: loginHeader,
          ));
      if (response.data != null) {
        return LoginResponseBodyDto.fromJson(response.data);
      } else {
        throw const ServerException(
          type: ServerExceptionType.notFound,
          message: 'data not found.',
        );
      }
    } on DioException catch (e) {
      return LoginResponseBodyDto.fromJson(e.response?.data);
    } on ServerException catch (err) {
      return LoginResponseBodyDto.fromJson(err.fullErrorResponse?.response.data);
    } catch (e) {
      throw ServerException(
        type: ServerExceptionType.notFound,
        message: '$e',
      );
    }
  }

  Future<SendOtpResponseBodyDto> sendMobileOtp(
      SendOtpRequestBodyDto requestBody) async {
    try {
      final response =
          await api.postData(path: otpPath, data: requestBody.toJson());
      if (response.data != null) {
        return SendOtpResponseBodyDto.fromJson(response.data);
      } else {
        throw const ServerException(
          type: ServerExceptionType.notFound,
          message: 'data not found.',
        );
      }
    } on DioException catch (e) {
      return SendOtpResponseBodyDto.fromJson(e.response?.data);
    } catch (e) {
      throw ServerException(
        type: ServerExceptionType.notFound,
        message: '$e',
      );
    }
  }

  Future<SignUpResponseBody> signUp(SignUpRequestBody signUpRequestBody) async {
    try {
      final response = await api.postData(
          path: signupUrl, data: signUpRequestBody.toJson());
      if (response.data != null) {
        return SignUpResponseBody.fromJson(response.data);
      } else {
        throw const ServerException(
          type: ServerExceptionType.notFound,
          message: 'data not found.',
        );
      }
    } on DioException catch (e) {
      return SignUpResponseBody.fromJson(e.response?.data);
    } catch (e) {
      throw ServerException(
        type: ServerExceptionType.notFound,
        message: '$e',
      );
    }
  }
}
