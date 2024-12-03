import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'content_type_interceptor.dart';

part 'pretty_logger.g.dart';

@Riverpod(keepAlive: true)
PrettyDioLogger getPrettyLogger(GetPrettyLoggerRef ref) {
  return PrettyDioLogger(
    request: true,
    requestBody: true,
    requestHeader: true,
    responseBody: true,
    responseHeader: true,
    logPrint: (log) {
      return debugPrint(log as String);
    },
  );
}

@Riverpod(keepAlive: true)
ApiInterceptor getApiInterceptor(GetApiInterceptorRef ref) => ApiInterceptor();