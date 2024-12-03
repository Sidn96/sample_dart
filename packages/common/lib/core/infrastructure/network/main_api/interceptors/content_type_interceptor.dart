import 'package:common/core/infrastructure/local_storage_data_source/secure_keys.dart';
import 'package:common/core/infrastructure/local_storage_data_source/secure_storage.dart';
import 'package:common/core/presentation/utils/extensions/string_extension.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:dio/dio.dart';

// class ContentTypeInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     if (options.data is FormData) {
//       options.headers[MainApiConfig.contentTypeHeaderKey] =
//           MainApiConfig.multipartFormDataContentType;
//     } else {
//       options.headers[MainApiConfig.contentTypeHeaderKey] =
//           MainApiConfig.emptyContentType;
//     }
//
//     return handler.next(options);
//   }
// }

class ApiInterceptor extends InterceptorsWrapper {
  ApiInterceptor();

  Future<Map<String, dynamic>> extraHeaderParam() async {
    Map<String, dynamic> params = {};
    String? partnerRef = await SecureStorage().getPref(key: AppConstants.partnerRefKey);
    String? utmSource = await SecureStorage().getPref(key:SecureKeys.utmsource);
    String? utmMedium = await SecureStorage().getPref(key:SecureKeys.utmmedium);
    String? utmCampaign = await SecureStorage().getPref(key:SecureKeys.utmcampaign);
    String? utmContent = await SecureStorage().getPref(key:SecureKeys.utmcontent);

    if(partnerRef.isNotNullNorEmpty()){
      params[AppConstants.partnerRefKey] = partnerRef;
    }
    if(utmSource.isNotNullNorEmpty()){
      params[SecureKeys.utmsource] = utmSource;
    }
    if(utmMedium.isNotNullNorEmpty()){
      params[SecureKeys.utmmedium] = utmMedium;
    }
    if(utmCampaign.isNotNullNorEmpty()){
      params[SecureKeys.utmcampaign] = utmCampaign;
    }
    if(utmContent.isNotNullNorEmpty()){
      params[SecureKeys.utmcontent] = utmContent;
    }
    return params;
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    Map<String, dynamic> extraParams = await extraHeaderParam();
    if(extraParams.isNotEmpty){
      options.headers.addAll(extraParams);
    }     
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  
}
