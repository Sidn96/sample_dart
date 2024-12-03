import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'store_local_preference.g.dart';

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());

@Riverpod(keepAlive: true)
LocalPreference localPreference(LocalPreferenceRef ref) {
  return LocalPreference(
    preferences: ref.watch(sharedPreferencesProvider),
  );
}

class LocalPreference {
  final SharedPreferences preferences;
  final String _isUserAppInstallUpdate = 'isUserAppInstallUpdate';
  final String _isTrueFinLoggedIn = "isTrueFinLoggedIn";
  final String _keyUserOnboardingLocation = 'userOnboardingLocation';
  final String _keyUserServiceAddress = 'userServiceAddress';
  final String _keyuserCartList = 'userCartList';

  LocalPreference({required this.preferences});
  //----------------------------------
  Future clearAllPreference() async => await preferences.clear();
  //--------------------------------------------------------------

  String? getStringData({required String key}) => preferences.getString(key);
  //--------------------------------------------------------------
  String? getUserCartList() => preferences.getString(_keyuserCartList);
  //--------------------------------------------------------------
  String getUserInstallOrUpdateAppVersion() =>
      preferences.getString(_isUserAppInstallUpdate) ?? "";
  //--------------------------------------------------------------
  bool getUserLoggedInState() =>
      preferences.getBool(_isTrueFinLoggedIn) ?? false;
  //--------------------------------------------------------------
  String? getUserOnboardingLocation() =>
      preferences.getString(_keyUserOnboardingLocation);
  //--------------------------------------------------------------
  String? getUserServiceAddress() =>
      preferences.getString(_keyUserServiceAddress);
  //--------------------------------------------------------------
  Future setStringData({required String key, required String val}) async =>
      await preferences.setString(key, val);
  //--------------------------------------------------------------
  Future<bool> setUserCartList(String val) async =>
      await preferences.setString(_keyuserCartList, val);
  //--------------------------------------------------------------
  Future<void> setUserInstallOrUpdateAppVersion(String version) async =>
      await preferences.setString(_isUserAppInstallUpdate, version);
  //--------------------------------------------------------------
  Future<void> setUserLoggedInState(bool value) async =>
      await preferences.setBool(_isTrueFinLoggedIn, value);
  //--------------------------------------------------------------
  Future<bool> setUserOnboardingLocation(String val) async =>
      await preferences.setString(_keyUserOnboardingLocation, val);
  //--------------------------------------------------------------
  Future<bool> setUserServiceAddress(String val) async =>
      await preferences.setString(_keyUserServiceAddress, val);
  //--------------------------------------------------------------
}
