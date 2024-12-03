import 'package:common/env/env.dart' as env;

abstract class MainApiConfig {
  static String baseUrl = env.Env.baseUrlFromEnv;
  static String moengageKey = env.Env.moengagekeyFromEnv;
  // static String baseWebUrl = env.Env.baseWebUrlFromEnv;
  static String snowPlowCollectorEndpoint = env.Env.snowplowCollectorEndpointFromEnv;

  static const Duration connectTimeout = Duration(seconds: 90);
  static const Duration receiveTimeout = Duration(seconds: 90);

  static const contentTypeHeaderKey = 'content-type';
  static const applicationJsonContentType = 'application/json';
  static const multipartFormDataContentType = 'multipart/form-data';
  static const emptyContentType = '';
}
