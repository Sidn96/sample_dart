import 'dart:async';

import 'package:common/core/domain/refresh_token_response_dto.dart';
import 'package:common/core/infrastructure/local_storage_data_source/secure_keys.dart';
import 'package:common/core/infrastructure/local_storage_data_source/secure_storage.dart';
import 'package:common/core/presentation/routing/global_navigation_utils.dart';
import 'package:common/core/presentation/utils/log_print.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../presentation/utils/riverpod_framework.dart';
import '../extensions/google_map_error_extension.dart';
import 'dio_providers.dart';

part 'api_facade.g.dart';

/// - parseFunction: a function that will attempt to parse the error from the server response
/// - failedParseHandler: a function that will handle the case when the parsing fails
dynamic parseErrorFromServerException({
  required Function parseFunction,
  required Function(dynamic) failedParseHandler,
}) {
  try {
    // Attempt to parse the error using the provided parseFunction
    return parseFunction();
  } catch (e) {
    // If an error occurs during parsing, call the failedParseHandler function with the error as argument
    return failedParseHandler(e);
  }
}

@Riverpod(keepAlive: true)
ApiFacade apiFacade(ApiFacadeRef ref) {
  return ApiFacade(
    dio: ref.watch(dioProvider),
  );
}

class ApiFacade {
  final Dio dio;

  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  /*bool callRefreshAPI = true;*/

  ApiFacade({required this.dio});

  Future<bool> callRefreshTokenAPI() async {
    String? token = await SecureStorage().getPref(key: SecureKeys.accessToken);
    String? rToken =
        await SecureStorage().getPref(key: SecureKeys.refreshToken);
    if (token != null && token != "" && rToken != null && rToken != "") {
      try {
        final refreshTokenResponse = await dio.get("/member/auth/refreshToken",
            options: Options(headers: {
              "Content-Type": "application/json",
              "AccessToken": token,
              "RefreshToken": rToken,
            }));
        if (refreshTokenResponse.data != null) {
          final refreshTokenValue =
              RefreshTokenResponseDto.fromJson(refreshTokenResponse.data);
          print(refreshTokenResponse);
          // Deleting just to take precaution as saving value in same key would overwrite value
          await SecureStorage().deletePref(key: SecureKeys.accessToken);
          await SecureStorage().deletePref(key: SecureKeys.refreshToken);
          await SecureStorage().setPref(
              key: SecureKeys.accessToken,
              value: refreshTokenValue.data.accessToken);
          await SecureStorage().setPref(
              key: SecureKeys.refreshToken,
              value: refreshTokenValue.data.refreshToken);
          return true;
        } else {
          return false;
        }
      } catch (err) {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<Response> deleteData({
    required String path,
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
    bool sendToken = false,
  }) async {
    return await _errorHandler(
      () async {
        if (sendToken) {
          options = await getUserToken();
        }
        return await dio.delete(
          path,
          data: data,
          options: options,
          cancelToken: cancelToken,
        );
      },
    );
  }

  Future<Response> deleteRawData({
    required String path,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
    bool sendToken = false,
  }) async {
    if (sendToken) {
      options = await getUserToken();
    }
    return dio.delete(
      path,
      queryParameters: queryParameters,
      data: data,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response> fetch({
    required String path,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _errorHandler(
      () async {
        return await dio.post(
          path,
          queryParameters: queryParameters,
          data: data,
          options: options,
          cancelToken: cancelToken,
        );
      },
    );
  }

  Future<Response> getData({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool sendToken = false,
    bool ignoreSessionExpire = false
  }) async {
    return await _errorHandler(
      () async {
        if (sendToken) {
          options = await getUserToken();
        }
        final res = await dio.get(
          path,
          queryParameters: queryParameters,
          //Every request can pass an Options object which will be merged with Dio.options
          options: options,
          cancelToken: cancelToken,
        );
        return res;
      },
      ignoreSessionExpire
    );
  }

  @Deprecated("Pls dont use this method anymore.Use getData")
  Future<Response> getDataRaw({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool sendToken = false,
  }) async {
    if (sendToken) {
      options = await getUserToken();
    }
    return dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    //   await _errorHandler(
    //   () async {
    //     return await
    //   },
    // );
  }

  Future<Options?> getUserToken() async {
    String? token = await SecureStorage().getPref(key: SecureKeys.accessToken);
    // String? token =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJtZW1iZXJJZCI6IjY0ZjJjYjQ4YWMxZTg2YzIwMzQxY2M2NSIsImNvbnRhY3RObyI6IjgyOTE0NTAwMTkiLCJhY2Nlc3NUb2tlbkdlbmVyYXRpb25EYXRlVGltZSI6IjIwMjMtMDktMDRUMTA6MjA6NDZaIiwiaWF0IjoxNjkzODIyODQ2LCJleHAiOjE2OTM5MDkyNDZ9.mYbkZUI8JhUHGt7r5Pt4KeKiDChXsA8i6RkhznjhSCY";
    if (token != null) {
      logPrint("token $token");
      return Options(
          headers: {"Content-Type": "application/json", "accesstoken": token});
    } else {
      return null;
    }
  }

  Future<Response> patchData({
    required String path,
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _errorHandler(
      () async {
        return await dio.patch(
          path,
          data: data,
          options: options,
          cancelToken: cancelToken,
        );
      },
    );
  }

  Future<Response> postData(
      {required String path,
      Map<String, dynamic>? queryParameters,
      dynamic data,
      Options? options,
      CancelToken? cancelToken,
      bool sendToken = false,
      bool ignoreSessionExpire = false}) async {
    return await _errorHandler(
      () async {
        if (sendToken) {
          options = await getUserToken();
        }
        return await dio.post(
          path,
          queryParameters: queryParameters,
          data: data,
          options: options,
          cancelToken: cancelToken,
        );
      },
      ignoreSessionExpire
    );
  }

  Future<Response> postTrackData(
      {required String path,
      Map<String, dynamic>? queryParameters,
      dynamic data,
      Options? options,
      CancelToken? cancelToken,
      Function(int, int)? onSendProgress,
      bool sendToken = false,
      bool ignoreSessionExpire = false}) async {
    return await _errorHandler(
      () async {
        if (sendToken) {
          options = await getUserToken();
        }
        return await dio.post(
          path,
          queryParameters: queryParameters,
          data: data,
          options: options,
          cancelToken: cancelToken,
          onSendProgress:onSendProgress
        );
      },
      ignoreSessionExpire
    );
  }

  @Deprecated("Pls dont use this method anymore.Use postData")
  Future<Response> postDataRaw({
    required String path,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
    bool sendToken = false,
  }) async {
    if (sendToken) {
      options = await getUserToken();
    }
    return dio.post(
      path,
      queryParameters: queryParameters,
      data: data,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response> putData({
    required String path,
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _errorHandler(
      () async {
        return await dio.put(
          path,
          data: data,
          options: options,
          cancelToken: cancelToken,
        );
      },
    );
  }

  Completer<bool> refreshTokenCompleter = Completer<bool>();
  bool tryingRefresh = false;

  Future<T> _errorHandler<T>(Future<T> Function() body,
      [bool ignoreSessionExpire = false]) async {
    try {
      return await body();
    } catch (e, st) {
      final error = e.googleMapErrorToServerException();
      if (!ignoreSessionExpire) { /// used ignoreSessionExpire to skip the flow when token is expired for mf-kyc campaign flow
        if (error.code == 401) {
          if (tryingRefresh == true) {
            //already trying to refresh wait for it to be refreshed and then check value
            bool didRefreshSuccessfully = await refreshTokenCompleter.future;
            if (didRefreshSuccessfully) {
              //if refreshed , call the body , else earlier api call will logout so no need for else
              return await body();
            }
          }
          //setting the boolean as true before trying refresh
          tryingRefresh = true;
          final value = await callRefreshTokenAPI();
          //after trying refresh setting the boolean as false
          tryingRefresh = false;
          //complete the refresh future so that incase other api calls are waiting , they will recall
          refreshTokenCompleter.complete(value);

          //reset the completer so that incase other api calls fail , it will again be available
          Timer(const Duration(seconds: 5), () {
            refreshTokenCompleter = Completer<bool>();
          });
          if (value) {
            /*callRefreshAPI = false;*/
            return await body();
          } else {
            //do logout
            /*callRefreshAPI = false;*/
            GlobalNavigationUtils.logoutCurrentApp();
            throw Error.throwWithStackTrace(error, st);
          }
          /* } else {
          throw Error.throwWithStackTrace(error, st);
        }*/
        } else {
          throw Error.throwWithStackTrace(error, st);
        }
      } else {
        return await body();
      }
    }
  }
}
