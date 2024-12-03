import 'package:common/core/infrastructure/dtos/user_info_dto.dart';
import 'package:common/core/infrastructure/error/app_exception.dart';
import 'package:common/core/infrastructure/local_storage_data_source/secure_keys.dart';
import 'package:common/core/infrastructure/local_storage_data_source/secure_storage.dart';
import 'package:common/core/infrastructure/network/main_api/api_callers/api_facade.dart';
import 'package:common/core/presentation/utils/app_errors.dart';
import 'package:common/features/login_signup/domain/signup_response_dto.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_signup_datasource.freezed.dart';

part 'login_signup_datasource.g.dart';

@riverpod
LoginRegisterDataSource loginRegisterDataSource(
    LoginRegisterDataSourceRef ref) {
  return LoginRegisterDataSource(ref.read(apiFacadeProvider));
}

class LoginRegisterDataSource {
  final ApiFacade _api;
  final String _otpPath = "/member/otp/send";
  final String _loginRegister = "/member/login-register";
  String memberInfoUrl = "/member/info";

  LoginRegisterDataSource(this._api);

  Future<LoginRegisterResponseEntity> callLoginRegisterApi(
      LoginRegisterRequest request) async {
    try {
      final response =
          await _api.postDataRaw(path: _loginRegister, data: request.toJson());
      if (response.data != null) {
        var result = LoginRegisterResponseEntity.fromJson(response.data);
        await _saveTokensInLocalStorage(result);
        return result;
      } else {
        throw const ServerException(
          type: ServerExceptionType.notFound,
          message: 'data not found.',
        );
      }
    } on DioException catch (e) {
      return LoginRegisterResponseEntity.fromJson(e.response?.data);
    } catch (e) {
      throw ServerException(
        type: ServerExceptionType.notFound,
        message: '$e',
      );
    }
  }

  Future<UserInfoDto> getMemberInfoApi() async {
    try {
      final response = await _api.getData(path: memberInfoUrl, sendToken: true);
      if (response.data != null) {
        UserInfoDto newInfo = UserInfoDto.fromJson(response.data);
        await SecureStorage().setPref(
            key: SecureKeys.memberInfo, value: userInfoDtoToJson(newInfo));
        return newInfo;
      } else {
        throw const ServerException(
          type: ServerExceptionType.notFound,
          message: 'data not found.',
        );
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

  Future<Either<String, SendOtpResponseEntity>> sendOtpApi(
      SendOtpRequest req) async {
    try {
      final response = await _api.postData(path: _otpPath, data: req.toJson());
      if (response.statusCode == 200) {
        return right(SendOtpResponseEntity.fromJson(response.data));
      }
      return left(SendOtpResponseEntity.fromJson(response.data).error ??
          AppErrors.mSomethingWentWrong);
    } on ServerException catch (e) {
      return left(
          SendOtpResponseEntity.fromJson(e.fullErrorResponse.response.data).error ??
              AppErrors.mSomethingWentWrong);
    } catch (e) {
      return left(AppErrors.mSomethingWentWrong);
    }
  }

  Future<void> _saveTokensInLocalStorage(
      LoginRegisterResponseEntity result) async {
    if (result.data?.tokens != null) {
      await SecureStorage().setPref(
        key: SecureKeys.accessToken,
        value: result.data!.tokens!.accessToken ?? '',
      );

      await SecureStorage().setPref(
        key: SecureKeys.refreshToken,
        value: result.data!.tokens!.refreshToken ?? '',
      );
    }
  }
}

@Freezed(toJson: true)
class LoginRegisterRequest with _$LoginRegisterRequest {
// contactNo: "9898989898"
// countryCode: "+91"
// isWhatsappCommEnabled: false
// otp: "3333"
// source: "nps"

  const factory LoginRegisterRequest({
    required String contactNo,
    required String countryCode,
    required bool isWhatsappCommEnabled,
    required String otp,
    required String source,
    required String policyText,
    required String dndOverrideText,
    required String whatsappCommText
  }) = _LoginRegisterRequest;
}

@Freezed(fromJson: true)
class LoginRegisterResponseEntity with _$LoginRegisterResponseEntity {
  const factory LoginRegisterResponseEntity(
      {final int? status,
      final bool? success,
      final String? message,
      final String? error,
      final Data? data}) = _LoginRegisterResponseEntity;

  factory LoginRegisterResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginRegisterResponseEntityFromJson(json);
}

@Freezed(toJson: true)
class SendOtpRequest with _$SendOtpRequest {
// countryCode: "+91"
// reference: "9898989898"
// referenceType: "contactno"
// source: "nps"
  const factory SendOtpRequest({
    required String countryCode,
    required String reference,
    required String referenceType,
    required String source,
  }) = _SendOtpRequest;
}

@Freezed(fromJson: true)
class SendOtpResponseEntity with _$SendOtpResponseEntity {
//  "status": 200,
//     "success": true,
//     "message": "OTP sent successfully",
//     "data": {},
//     "error": ""

  const factory SendOtpResponseEntity(
      {final int? status,
      final bool? success,
      final String? message,
      final String? error,
      final Map<String, dynamic>? data}) = _SendOtpResponseEntity;

  factory SendOtpResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$SendOtpResponseEntityFromJson(json);
}
