import 'package:common/core/infrastructure/network/main_api/api_callers/api_facade.dart';
import 'package:common/core/presentation/providers/connectivity_checker.dart';
import 'package:common/features/member_pal_login/data/dtos/member_pal_login_response_dto.dart';
import 'package:common/features/member_pal_login/domain/entities/member_pal_login_request_entity.dart';
import 'package:common/features/member_pal_login/domain/entities/send_otp_request_entity.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'member_pal_login_remote_data_source.g.dart';

@riverpod
MemberPalLoginRemoteDataSource memberPalLoginRemoteDataSource(
    MemberPalLoginRemoteDataSourceRef ref) {
  return MemberPalLoginRemoteDataSource(
    api: ref.watch(apiFacadeProvider),
    connectivityStatus: ref.watch(connectivityCheckerNotifierProvider),
  );
}

class MemberPalLoginRemoteDataSource {
  final ApiFacade api;
  final ConnectivityStatus connectivityStatus;
  final String sendOtpEndPoin = "/member/otp/send";
  final String loginRegister = "/member/login-register";

  MemberPalLoginRemoteDataSource(
      {required this.api, required this.connectivityStatus});

  Future<MemberPalLoginResponseDto> memberPalLoginRegister(
      {required MemberPalLoginRequestEntity requestEntity}) async {
    try {
      final response = await api.postDataRaw(
          path: loginRegister, data: requestEntity.toJson());

      if (response.data != null) {
        return MemberPalLoginResponseDto.fromJson(response.data);
      } else {
        return MemberPalLoginResponseDto.fromJson(response.data);
      }
    } on DioException catch (e) {
      return MemberPalLoginResponseDto.fromJson(e.response?.data);
    } catch (e) {
      return const MemberPalLoginResponseDto(status: 404, success: false);
    }
  }

  Future<bool> memberPalSendOtp(
      {required SendOtpRequestEntity sendOtpEntity}) async {
    try {
      final response = await api.postData(
          path: sendOtpEndPoin, data: sendOtpEntity.toJson());

      if (response.data != null) {
        return response.data["success"];
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
