import 'package:flutter/services.dart';

abstract class CertReader {
  static ByteData? cert;

  static Future<void> initialize(String key) async {
    cert = await rootBundle.load(key);
  }

  static ByteData? getCert() {
    return cert;
  }
}