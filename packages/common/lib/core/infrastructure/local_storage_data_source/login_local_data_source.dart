import 'package:common/core/infrastructure/dtos/user_info_dto.dart';
import 'package:common/core/infrastructure/error/app_exception.dart';
import 'package:common/core/infrastructure/local/secure_storage_facade.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_local_data_source.g.dart';

@Riverpod(keepAlive: true)
LoginLocalDataSource loginLocalDataSource(LoginLocalDataSourceRef ref) {
  return LoginLocalDataSource(
    secureStorage: ref.watch(secureStorageFacadeProvider),
  );
}

class LoginLocalDataSource {
  LoginLocalDataSource({required this.secureStorage});

  final SecureStorageFacade secureStorage;

  static const String userTokenKey = 'userTokenKey';
  static const String txnNoTokenKey = 'txnNOTokenKey';
  static const String userRefreshTokenKey = 'userRefreshTokenKey';
  static const String userDataKey = 'userDataKey';

  Future<void> cacheUserInfo(UserInfoDto data) async {
    await secureStorage.saveData(
        key: userDataKey, value: userInfoDtoToJson(data));
  }

  Future<UserInfoDto> getCachedUserInfo() async {
    final jsonString = await secureStorage.restoreData(key: userDataKey);
    final UserInfoDto userInfoDto = userInfoDtoFromJson(jsonString);
    return userInfoDto;
  }

  Future<void> cacheUserToken(String token) async {
    await secureStorage.saveData(
      key: userTokenKey,
      //dataType: DataType.string,
      value: token,
    );
  }

  Future<String?> getCachedUserToken() async {
    final jsonString = await secureStorage.restoreData(
      key: userTokenKey,
      //dataType: DataType.string,
    );
    if (jsonString != null) {
      return jsonString;
    } else {
      return null;
    }
  }

  Future<void> cacheTxnNoToken(String txnNO) async {
    await secureStorage.saveData(
      key: txnNoTokenKey,
      //dataType: DataType.string,
      value: txnNO,
    );
  }

  Future<String> getcachedTxnNoToken() async {
    final jsonString = await secureStorage.restoreData(
      key: txnNoTokenKey,
      //dataType: DataType.string,
    );
    if (jsonString != null) {
      return jsonString;
    } else {
      throw const CacheException(
        type: CacheExceptionType.notFound,
        message: 'Cache Not Found',
      );
    }
  }

  Future<void> cacheRefreshToken(String refreshToken) async {
    await secureStorage.saveData(
      key: userRefreshTokenKey,
      //dataType: DataType.string,
      value: refreshToken,
    );
  }

  Future<String> getCachedRefreshToken() async {
    final jsonString = await secureStorage.restoreData(
      key: userRefreshTokenKey,
      //dataType: DataType.string,
    );
    if (jsonString != null) {
      return jsonString;
    } else {
      throw const CacheException(
        type: CacheExceptionType.notFound,
        message: 'Cache Not Found',
      );
    }
  }
}
