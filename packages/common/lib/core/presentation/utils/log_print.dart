import 'dart:developer';

import 'package:flutter/foundation.dart';

void logPrint(String tag, {String? message}) {
  if (kReleaseMode) return;
  log('$tag $message');
}
