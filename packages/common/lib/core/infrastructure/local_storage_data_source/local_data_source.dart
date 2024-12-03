import 'package:common/core/infrastructure/local_storage_data_source/secure_keys.dart';
import 'package:common/core/infrastructure/local_storage_data_source/secure_storage.dart';

abstract class LocalDataSource {
  Future<String?> getString(String key, {String? defaultValue});

  Future<String?> getUserToken();
}

class LocalDataSourceImpl extends LocalDataSource {
  final SecureStorage secureStorage = SecureStorage();

  @override
  Future<String?> getString(String key, {String? defaultValue}) async {
    return await secureStorage.getPref(key: key, defaultValue: defaultValue);
  }

  @override
  Future<String?> getUserToken() async {
    return await secureStorage.getPref(key: SecureKeys.accessToken);
  }
}
