import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'network/main_api/api_callers/api_facade.dart';

part 'api_result.freezed.dart';
part 'api_result.g.dart';

abstract class ApiResult<T> {
  static const String _jsonNodeData = "data";
  static const String _jsonNodeStatus = "status";
  static const String _jsonNodeStatusCode = "statusCode";

  static Function(Map<String, dynamic>) get emptyMapper => (Map<String, dynamic> d) => {};

  //TODO Incomplete method
  static Future<ApiResult<T>> fromPostRequest<T>(
      ApiFacade apiFacade,
      String endPoint,
      Map<String, dynamic> requestData,
      T Function(Map<String, dynamic>) mapper,
      {bool sendToken = false,
      bool shouldRetry = true}) async {

    var res = await apiFacade.postData(
        path: endPoint, data: requestData, sendToken: sendToken);

    var result = fromResponse(res, mapper);

    if (result is ServerError) {
      if ((result as ServerError).errors.status == 401) {
        if (!shouldRetry) {
          return TokenExpired();
        }

        //TODO refresh token logic
        fromPostRequest(apiFacade, endPoint, requestData, mapper,
            sendToken: sendToken, shouldRetry: false);
      }
    }
    return result;
  }

  /// This method works only with Map response
  static ApiResult<T> fromResponse<T>(
      Response response, T Function(Map<String, dynamic>) mapper) {
    final responseData = response.data;

    bool correctResponse = (responseData[_jsonNodeStatus] != null &&
        responseData[_jsonNodeStatus] == 200) || (
        responseData[_jsonNodeStatusCode] == 200);
    //TODO temp below line, change it - Dinesh
    correctResponse = correctResponse || responseData[_jsonNodeStatusCode] == 206;
    if (!correctResponse) {
      return ServerError.fromResponse(response);
    } else if (correctResponse && responseData[_jsonNodeData] != null) {
      // debugPrint("Response Data: ${response.data}");
      // debugPrint("Response Data 1: ${response.data[_jsonNodeData]}");
      // debugPrint("a: ${a.toString()}");
      // return Success(mapper(response.data));
      if (response.data[_jsonNodeData] is Map<String, dynamic>) {
        var responseMap = (response.data[_jsonNodeData] as Map<String, dynamic>);
        return Success(mapper(responseMap), isEmptyData: responseMap.isEmpty);
      } else {
        return Success(mapper(responseData));
      }
    } else {
      return InternalError(null);
    }
  }

  static ApiResult<List<T>> fromListResponse<T>(
      Response response, T Function(Map<String, dynamic>) mapper) {
    final responseData = response.data;

    final correctResponse = responseData[_jsonNodeStatus] != null &&
        responseData[_jsonNodeStatus] == 200 || (
        responseData[_jsonNodeStatusCode] == 200);
    if (!correctResponse) {
      return ServerError.fromResponse(response);
    } else if (correctResponse && responseData[_jsonNodeData] != null) {
      var l = <T>[];
      if (response.data[_jsonNodeData] is List) {
        var rList = response.data[_jsonNodeData];
        for (var d in rList) {
          l.add(mapper(d));
        }
      }
      return Success(l);
    } else {
      return InternalError(null);
    }
  }
}

class Success<T> extends ApiResult<T> {
  final T data;
  final bool isEmptyData;

  Success(this.data, {this.isEmptyData = false});
}

class Failed<T> extends ApiResult<T> {
  ApiError errors;

  Failed(this.errors);
}

class ServerError<T> extends Failed<T> {
  ServerError(ApiError errors) : super(errors);

  static ServerError<T> fromResponse<T>(Response response) {
    return ServerError(ApiError.fromJson(response.data));
  }
}

// class NetworkError<T> extends Failed<T> {
//   NetworkError(ApiError errors) : super(errors);
// }

class InternalError<T> extends ApiResult<T> {
  final String? msg;

  InternalError(this.msg);
}

class TokenExpired<T> extends ApiResult<T> {
  TokenExpired();
}

class EmptyResponse<T> extends ApiResult<T> {
  EmptyResponse();
}

///----
@freezed
class ApiError with _$ApiError {

  const ApiError._();

  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory ApiError({
    @JsonKey(name: "status")
    int? status1,
    @JsonKey(name: "statusCode")
    int? statusCode,
    final bool? success,
    final String? message,
    final String? requestId,
    final String? error,
  }) = _ApiError;

  int get status => status1 ?? statusCode ?? -1;

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);
}
