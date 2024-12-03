import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'extensions/local_error_extension.dart';

part 'secure_storage_facade.g.dart';

@Riverpod(keepAlive: true)
FlutterSecureStorage secureStorage(SecureStorageRef ref) {
  return const FlutterSecureStorage();
}

// @Riverpod(keepAlive: true)
// FlutterSecureStorage _secureStorage(_SecureStorageRef ref) {
//   return ref.watch(secureStorageProvider).;
// }

@Riverpod(keepAlive: true)
SecureStorageFacade secureStorageFacade(SecureStorageFacadeRef ref) {
  return SecureStorageFacade(
    flutterSecureStorage: ref.watch(secureStorageProvider),
  );
}

class SecureStorageFacade {
  SecureStorageFacade({required this.flutterSecureStorage});

  final FlutterSecureStorage flutterSecureStorage;

  /*
  late final bool hasHistory;
  initHasHistory() async {
    hasHistory =
        await restoreData(key: 'has_history', dataType: DataType.bool) ?? false;
    log('hasHistory: ' + hasHistory.toString());
    if (!hasHistory){
      saveData(key: 'has_history', value: true, dataType: DataType.bool);
    }
  }*/

  saveData({
    required String key,
    required String value,
  }) async {
    await getSetMethod(key, value);
  }

  Future<dynamic> restoreData({
    required String key,
    bool allData = false,
  }) async {
    return await getGetMethod(key);
  }

  Future<bool> clearAll() async {
    return await _errorHandler(
      () async {
        return await flutterSecureStorage.deleteAll();
      },
    );
  }

  Future<bool> clearKey({required key}) async {
    return await _errorHandler(
      () async {
        return await flutterSecureStorage.delete(key: key);
      },
    );
  }

  getSetMethod(String key, String value) async {
    try {
      await flutterSecureStorage.write(key: key, value: value);
    } catch (error) {
      print(error.toString());
    }
  }

  getGetMethod(String key, {bool allData = false}) {
    if (allData) {
      return flutterSecureStorage.readAll();
    } else {
      return flutterSecureStorage.read(key: key);
    }
  }

  Future<T> _errorHandler<T>(Function body) async {
    try {
      return await body.call();
    } catch (e, st) {
      final error = e.localErrorToCacheException();
      throw Error.throwWithStackTrace(error, st);
    }
  }
}
