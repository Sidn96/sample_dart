import 'package:common/core/infrastructure/dtos/send_mobile_otp_response_model_dto.dart';
import 'package:common/core/infrastructure/error/app_exception.dart';
import 'package:common/core/infrastructure/network/main_api/api_callers/api_facade.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:dio/dio.dart';
import '../dtos/validate_mobile_otp_response_model_dto.dart';

part 'login_otp_remote_data_source.g.dart';

@Riverpod(keepAlive: true)
LoginRemoteDataSource loginRemoteDataSource(
    LoginRemoteDataSourceRef ref) {
  return LoginRemoteDataSource(
    ref,
    api: ref.watch(apiFacadeProvider),
  );
}

class LoginRemoteDataSource {
  LoginRemoteDataSource(
    this.ref, {
    required this.api,
  });

  final LoginRemoteDataSourceRef ref;
  final ApiFacade api;

  Future<SendMobileOTPResponseModelDto> sendMobileOtpApi(
      Map<String, dynamic> requestBody,String path) async {
    try {
      final response = await api.postDataRaw(
        path: path,
        data: requestBody,
      );

      print("sendMobileOtpApi  response : ${response.data}");

      if (response.data != null) {
        return SendMobileOTPResponseModelDto.fromJson(response.data);
      } else {
        throw const ServerException(
          type: ServerExceptionType.notFound,
          message: 'Data not found.',
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        return SendMobileOTPResponseModelDto.fromJson(e.response?.data);
      }
      rethrow;
    } catch (e) {
      throw ServerException(
        type: ServerExceptionType.notFound,
        message: '$e',
      );
    }
  }

  Future<ValidateMobileOTPFCResponseModelDto> validateMobileOtpApi(
      Map<String,dynamic> requestBody,String path) async {
    try {
      final response = await api.postDataRaw(
          path: path,
          data: requestBody,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*"
          }));

      if (response.data != null) {
        return ValidateMobileOTPFCResponseModelDto.fromJson(response.data);
      } else {
        throw const ServerException(
          type: ServerExceptionType.notFound,
          message: 'Data not found.',
        );
      }
    }  on DioException catch (e) {
        return ValidateMobileOTPFCResponseModelDto.fromJson(e.response?.data);
    } catch (e) {
      throw ServerException(
        type: ServerExceptionType.notFound,
        message: '$e',
      );
    }
  }
}
