import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  //This needed if your api use statusCode 200 for business errors..
  //If has error, we reject with proper DioError: [error message from backend / statusCode 400 / DioErrorType.response]
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    /// following code is from dev
    if (response.data?['status'] != 200) {
      final tError = DioException(
        error: response.data?['message'],
        response: Response(
          requestOptions: RequestOptions(path: response.requestOptions.path),
          statusCode: response.data?['status'],
        ),
        requestOptions: RequestOptions(path: response.requestOptions.path),
        type: DioExceptionType.badResponse,
      );
      return handler.reject(tError);
    }

    // following code is modified to attempt to resolve error handling
    // if (response.data?['status'] != null) {
    //   if (response.data?['status'] != 200) {
    //     final tError = handleException(response, true);
    //     return handler.reject(tError);
    //   }
    // } else if (response.data?['statusCode'] != null) {
    //   if (response.data?['statusCode'] != 200) {
    //     final tError = handleException(response, false);
    //     return handler.reject(tError);
    //   }
    // }
    // return handler.next(response);
  }

  DioException handleException(Response response, bool isStatus) {
    print("handleException => isStatus : $isStatus");
    final tError = DioException(
      error: response.data['message'],
      response: Response(
        requestOptions: RequestOptions(path: response.requestOptions.path),
        statusCode:
            !isStatus ? response.data['statusCode'] : response.data['status'],
      ),
      requestOptions: RequestOptions(path: response.requestOptions.path),
      type: DioExceptionType.badResponse,
    );

    return tError;
  }

//This needed if your api throw custom statusCode for business errors..
//We override DioError message with error message from backend and DioError type with DioErrorType.response
/*
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;

    if (statusCode == 400 || statusCode == 424) {
      err.error = err.response!.data['error_description'];
      err.type = DioErrorType.response;
      return handler.reject(err);
    }

    return handler.next(err);
  }*/
}
