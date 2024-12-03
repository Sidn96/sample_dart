// NOTE: this code is mostly copied from https://codewithandrea.com/articles/flutter-api-keys-dart-define-env-files/
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '../../.env', requireEnvFile: true, obfuscate: false)
abstract class Env {
  @EnviedField(varName: 'BASE_API_URL')
  static const String baseUrlFromEnv = _Env.baseUrlFromEnv;
  @EnviedField(varName: 'CONTENTFUL_BASE_API_URL')
  static const String contentfulBaseUrlFromEnv = _Env.contentfulBaseUrlFromEnv;
  @EnviedField(varName: 'OPSPANEL_BASE_API_URL')
  static const String opsPanelBaseUrlFromEnv = _Env.opsPanelBaseUrlFromEnv;
  @EnviedField(varName: 'TAX2WIN_WEB_URL')
  static const String tax2WinWebUrlFromEnv = _Env.tax2WinWebUrlFromEnv;
  @EnviedField(varName: 'MOENGAGE_KEY')
  static const String moengagekeyFromEnv = _Env.moengagekeyFromEnv;
  @EnviedField(varName: 'SNOWPLOW_COLLECTOR_ENDPOINT')
  static const String snowplowCollectorEndpointFromEnv =
      _Env.snowplowCollectorEndpointFromEnv;
  @EnviedField(varName: 'GROWTHBOOK_API_KEY')
  static const String growthBookApiKey = _Env.growthBookApiKey;

  static final Environment appEnvironment = baseUrlFromEnv.contains("dev")
      ? Environment.dev
      : baseUrlFromEnv.contains("staging")
          ? Environment.staging
          : Environment.prod;
}

enum Environment { dev, staging, prod }
