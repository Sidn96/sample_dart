import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  AppInfo._();

  /// this is used to compare app versions
  static Future<String> getAppVersion() async {
    final v = await PackageInfo.fromPlatform();
    return v.version;
  }

   static Future<String> getBuildNumber() async {
    final v = await PackageInfo.fromPlatform();
    return v.buildNumber;
  }

  /// this is used only for display purpose
  static Future<String> getAppInfo() async {
    final v = await PackageInfo.fromPlatform();
    // versionString.value = '${v.version} - ${v.buildNumber}';
    return 'v ${v.version}';
  }
}
