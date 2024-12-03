//check if the tutorial is completed
import 'package:common/core/infrastructure/local_storage_data_source/shared_prefs_keys.dart';
import 'package:common/core/infrastructure/local_storage_data_source/shared_prefs_service.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<String> getUserInstallOrUpdateAppVersion() async {
  final pref = await SharedPreferencesService.getInstance();
  final result =
      (pref.getString(SharedPreferencesKeys.isUserAppInstallUpdate)) ?? "";
  debugPrint("result = $result");
  return result;
}

Future<void> setUserInstallOrUpdateAppVersion() async {
  final pref = await SharedPreferencesService.getInstance();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  await pref.setString(SharedPreferencesKeys.isUserAppInstallUpdate,
      "${packageInfo.version}+${packageInfo.buildNumber}");
}
