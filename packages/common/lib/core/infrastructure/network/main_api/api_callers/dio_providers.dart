import 'dart:io';

import 'package:collection/collection.dart';
import 'package:common/core/infrastructure/network/cert_reader.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';

import '../../../../presentation/utils/riverpod_framework.dart';
import '../interceptors/pretty_logger.dart';
import '../main_api_config.dart';

part 'dio_providers.g.dart';

//Note: If you've different subdomains of an API (need same interceptors and other options but different baseUrl),
//then you can use one instance of dio and override the base URL dynamically
@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  // Initialize Dio instance
  Dio dio = Dio();

  // Load certificate bytes for SSL pinning
  ByteData bytes = CertReader.getCert()!;

  // Convert certificate bytes to Uint8List for SSL pinning
  Uint8List trustedCertBytes = bytes.buffer.asUint8List();

  // Calculate SHA-256 fingerprint of the trusted certificate for comparison
  final trustedCertFingerprint = sha256.convert(trustedCertBytes).toString();

  dio.httpClientAdapter = IOHttpClientAdapter()
    ..createHttpClient = () {
      // Initialize a security context and set the trusted certificate
      SecurityContext sc = SecurityContext();
      sc.setTrustedCertificatesBytes(trustedCertBytes);

      // Create an HTTP client with the specified security context
      HttpClient httpClient = HttpClient(context: sc);
      // SSL pinning: Compare the server certificate with the trusted certificate
      httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        // Calculate SHA-256 fingerprint of the server's certificate
        final serverCertFingerprint = sha256.convert(cert.der).toString();
        // Return true if fingerprints match, allowing the connection
        return serverCertFingerprint == trustedCertFingerprint;
      };
      return httpClient;
    };

  return dio
    ..options = BaseOptions(
      baseUrl: MainApiConfig.baseUrl,
      connectTimeout: MainApiConfig.connectTimeout,
      receiveTimeout: MainApiConfig.receiveTimeout,
      headers: {
        "Accept": "*/*",
        //"Accept-Encoding": "gzip,deflate",
        "Accept-Language": "en-US,en",
        //"Connection": "Keep-Alive",
      },
    )
    ..interceptors.addAll([
      //order is necessary.
      if (kDebugMode) ref.read(getPrettyLoggerProvider),
      ref.read(getApiInterceptorProvider),
      //ErrorInterceptor(),
    ]);
}
