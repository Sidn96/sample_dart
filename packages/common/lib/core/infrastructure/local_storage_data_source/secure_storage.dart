import 'package:common/core/infrastructure/local_storage_data_source/secure_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final SecureStorage _instance = SecureStorage._internal();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage(
    aOptions: SecureKeys().getAndroidOptions(),
  );
  factory SecureStorage() => _instance;

  SecureStorage._internal();

  Future<void> deleteAllPref() async {
    try {
      return await SecureStorage()._secureStorage.deleteAll();
    } catch (e) {
      debugPrint('deleteAllPref() => $e'); // Need to remove this later
    }
  }

  Future<void> deletePref({required String key}) async {
    try {
      var contains = await SecureStorage()._secureStorage.containsKey(key: key);

      if (contains) {
        return await SecureStorage()._secureStorage.delete(key: key);
      }
    } on PlatformException catch (e) {
      debugPrint('deletePref() => $e'); // Need to remove this later
      await SecureStorage()._secureStorage.deleteAll();
    }
  }

  Future<bool> getBoolean({required String key, dynamic defaultValue}) async {
    try {
      var contains = await SecureStorage()._secureStorage.containsKey(key: key);

      if (contains) {
        var lb = await SecureStorage()._secureStorage.read(key: key);
        return lb?.toLowerCase() == 'true';
      }
    } on PlatformException catch (e) {
      debugPrint('getBoolean() => $e'); // Need to remove this later
      await SecureStorage().deleteAllPref();
    }
    if (defaultValue != null) return defaultValue;
    return false;
  }

  /// helper functions to communicate with secure storage
  Future<String?> getPref({required String key, String? defaultValue}) async {
    try {
      var contains = await SecureStorage()._secureStorage.containsKey(key: key);
      if (contains) return await SecureStorage()._secureStorage.read(key: key);
    } on PlatformException catch (e) {
      debugPrint('getPref() => $e'); // Need to remove this later
      await SecureStorage().deleteAllPref();
    } catch(e){
      return null;
    }
    /*if (defaultValue != null) */
    return defaultValue;
    //return '';
  }

  Future<void> setPref({required String key, required String value}) async {
    try {
      debugPrint('setPref() => saved key $key \t value = $value');
      return await SecureStorage()._secureStorage.write(key: key, value: value);
    } catch (e) {
      debugPrint('setPref() => $e'); // Need to remove this later
    }
  }
}
