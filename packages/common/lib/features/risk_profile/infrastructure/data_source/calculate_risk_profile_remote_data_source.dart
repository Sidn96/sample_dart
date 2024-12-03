import 'package:common/core/infrastructure/error/app_exception.dart';
import 'package:common/core/infrastructure/network/main_api/api_callers/api_facade.dart';
import 'package:common/core/infrastructure/network/main_api/api_endpoints.dart';
import 'package:common/features/risk_profile/infrastructure/dtos/calculate_risk_profile_request_dto.dart';
import 'package:common/features/risk_profile/infrastructure/dtos/calculate_risk_profile_response_dto_custom.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'calculate_risk_profile_remote_data_source.g.dart';

@Riverpod(keepAlive: true)
RiskProfileCalculateDataSource riskProfileCalculateDataSource(
    RiskProfileCalculateDataSourceRef ref) {
  return RiskProfileCalculateDataSource(
    ref,
    api: ref.watch(apiFacadeProvider),
  );
}

class RiskProfileCalculateDataSource {
  RiskProfileCalculateDataSource(
    this.ref, {
    required this.api,
  });

  final RiskProfileCalculateDataSourceRef ref;
  final ApiFacade api;

  Future<CalculateRiskProfileResponseDtoCustom> postRiskProfileCalculatedData(
      CalculateRiskProfileRequestDto calculateRiskProfileRequestDto,
      String token) async {
    try {
      final response = await api.postData(
        sendToken: true,
        path: ApiEndPoints.calculateRiskProfile,
        data: calculateRiskProfileRequestDto,
      );

      if (response.data != null) {
        return CalculateRiskProfileResponseDtoCustom.fromJson(response.data);
      } else {
        throw const ServerException(
          type: ServerExceptionType.notFound,
          message: 'Risk profile Data not found.',
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 403) {
        return CalculateRiskProfileResponseDtoCustom.fromJson(e.response?.data);
      }
      rethrow;
    } catch (e) {
      throw ServerException(
        type: ServerExceptionType.notFound,
        message: '$e',
      );
    }
  }

  Future<CalculateRiskProfileResponseDtoCustom> getRiskProfileCalculatedData() async {
    try {
      final response = await api.getData(
        sendToken: true,
        path: ApiEndPoints.calculateRiskProfile,
      );

      if (response.data != null) {
        return CalculateRiskProfileResponseDtoCustom.fromJson(response.data);
      } else {
        throw const ServerException(
          type: ServerExceptionType.notFound,
          message: 'Risk profile Data not found.',
        );
      }
    }
    on ServerException catch (e) {
      return CalculateRiskProfileResponseDtoCustom.fromJson(e.fullErrorResponse.response?.data);
    }
    // on DioException catch (e) {
    //   if (e.response?.statusCode == 400 ||
    //       e.response?.statusCode == 401 ||
    //       e.response?.statusCode == 403 ||
    //       e.response?.statusCode == 404) {
    //     return CalculateRiskProfileResponseDto.fromJson(e.response?.data);
    //   }
    //   rethrow;
    // }
    catch (e) {
      throw ServerException(
        type: ServerExceptionType.notFound,
        message: '$e',
      );
    }
  }
}
