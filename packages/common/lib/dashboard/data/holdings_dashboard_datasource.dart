import 'package:common/core/infrastructure/api_result.dart';
import 'package:common/core/infrastructure/error/app_exception.dart';
import 'package:common/core/infrastructure/network/main_api/api_callers/api_facade.dart';
import 'package:common/core/infrastructure/network/main_api/api_endpoints.dart';
import 'package:common/features/risk_profile/infrastructure/dtos/calculate_risk_profile_response_dto_custom.dart';
import 'package:mf_pod/infrastructure/constants/mf_api_constants.dart';
import 'package:mf_pod/infrastructure/dtos/get_portfolio_allocation_dto.dart';

class HoldingsDashboardDatasource {
  final ApiFacade _apiFacade;

  const HoldingsDashboardDatasource(this._apiFacade);

  Future<CalculateRiskProfileResponseDtoCustom> getRiskProfile<T>(
      {required T Function(Map<String, dynamic>) mapper}) async {
    try {
      var response = await _apiFacade.getData(
        path: ApiEndPoints.calculateRiskProfile,
        sendToken: true,
      );

      return CalculateRiskProfileResponseDtoCustom.fromJson(response.data);
    } on ServerException catch (err) {
      try {
        throw ServerException(
          type: ServerExceptionType.notFound,
          message: '$err',
        );
      } catch (err1) {
        throw const ServerException(
          type: ServerExceptionType.notFound,
          message: 'Internal Error, Something went wrong',
        );
        // return InternalError('Internal Error, Something went wrong');
      }
    } catch (e) {
      throw const ServerException(
        type: ServerExceptionType.notFound,
        message: 'Internal Error, Something went wrong',
      );
      // return InternalError('Internal Error, Something went wrong');
    }
  }

  Future<GetPortfolioAllocationDto> getPortfolioAllocation<T>(
      {required T Function(Map<String, dynamic>) mapper,required int age,required String riskProfile}) async {
    try {
      var response = await _apiFacade.getData(
        path: MfApiConstants.getPortfolioAllocation,
        queryParameters: {'age': age,'riskProfile' : riskProfile},
        sendToken: true,
      );

      return GetPortfolioAllocationDto.fromJson(response.data);
    } on ServerException catch (err) {
      try {
        throw ServerException(
          type: ServerExceptionType.notFound,
          message: '$err',
        );
      } catch (err1) {
        throw const ServerException(
          type: ServerExceptionType.notFound,
          message: 'Internal Error, Something went wrong',
        );
        // return InternalError('Internal Error, Something went wrong');
      }
    } catch (e) {
      throw const ServerException(
        type: ServerExceptionType.notFound,
        message: 'Internal Error, Something went wrong',
      );
      // return InternalError('Internal Error, Something went wrong');
    }
  }

  Future<ApiResult> getMfSyncHoldings<T>(
      {required T Function(Map<String, dynamic>) mapper}) async {
    try {
      var response = await _apiFacade.getData(
        path: MfApiConstants.syncMfKycV2,
        sendToken: true,
        ignoreSessionExpire: true
      );

      return ApiResult.fromResponse(response, mapper);
    } on ServerException catch (err) {
      try {
        return ServerError.fromResponse(err.fullErrorResponse?.response);
      } catch (err1) {
        return InternalError('Internal Error, Something went wrong');
      }
    } catch (e) {
      return InternalError('Internal Error, Something went wrong');
    }
  }
}