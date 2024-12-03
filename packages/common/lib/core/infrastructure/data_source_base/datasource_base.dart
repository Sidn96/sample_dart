import 'package:common/core/infrastructure/api_result.dart';
import 'package:common/core/infrastructure/error/app_exception.dart';
import 'package:common/core/infrastructure/network/main_api/api_callers/api_facade.dart';

class DatasourceBase {
  final ApiFacade _apiFacade;

  const DatasourceBase(this._apiFacade);

  Future<ApiResult> getData<T>(
      String endPoint, T Function(Map<String, dynamic>) mapper,
      {bool listOfResponse = false,
      bool sendToken = true,
      Map<String, dynamic>? queryParam,
      bool ignoreSessionExpire = false}) async {j
    try {
      var response = await _apiFacade.getData(
          path: endPoint,
          sendToken: sendToken,
          queryParameters: queryParam,
          ignoreSessionExpire: ignoreSessionExpire);

      ///If response data is a type of List then just pass Mapper list will automatically created
      if (listOfResponse) {
        return ApiResult.fromListResponse(response, mapper);
      }
      return ApiResult.fromResponse(response, mapper);
    } on ServerException catch (err) {
      if (err.type == ServerExceptionType.notFound) return EmptyResponse();

      var e = err.fullErrorResponse;
      try {
        return ServerError.fromResponse(e?.response);
      } catch (e) {
        return InternalError('Internal Error, Something went wrong');
      }
    } catch (e) {
      return InternalError('Internal Error, Something went wrong : Error-> $e');
    }
  }

  Future<ApiResult> postData<T>(
      String endPoint,
      // Map<String, dynamic>? request,
      dynamic request,
      T Function(Map<String, dynamic>) mapper,
      {bool listOfResponse = false,
      bool ignoreSessionExpire = false}) async {
    try {
      var response = await _apiFacade.postData(
          path: endPoint,
          data: request,
          sendToken: true,
          ignoreSessionExpire: ignoreSessionExpire);

      if (listOfResponse) {
        return ApiResult.fromListResponse(response, mapper);
      }

      return ApiResult.fromResponse(response, mapper);
    } on ServerException catch (err) {
      //TODO for 401 case
      // call callRefreshTokenAPI
      // await _apiFacade.callRefreshTokenAPI();
      if (err.type == ServerExceptionType.notFound) return EmptyResponse();
      try {
        var e = err.fullErrorResponse;
        return ServerError.fromResponse(e?.response);
      } catch (err1) {
        return InternalError('Internal Error, Something went wrong');
      }
    } catch (e) {
      return InternalError('Internal Error, Something went wrong');
    }
  }
}

/// Simple class same as Either
class DataOrError<T> {
  final T? data;
  final String? _errorMsg;

  DataOrError._(this.data, this._errorMsg);

  DataOrError.withData(T data) : this._(data, null);

  DataOrError.withError(String err) : this._(null, err);

  bool get hasData => data != null;

  bool get hasError => !hasData;

  String get errorMsg => _errorMsg ?? "Something Went Wrong!";
}
