import 'dart:io';

import 'package:in_app_update/in_app_update.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:common/core/consts/constant_app_strings.dart';
import 'package:common/core/presentation/utils/app_info.dart';
import 'package:common/features/app_update/data/repos/appupdate_check_repo.dart';
import 'package:common/features/profile/presentation/common_imports.dart';

part 'appupdate_check_provider.g.dart';

@riverpod
class AppUpdateCheck extends _$AppUpdateCheck {
  String header = AppStrings.appUpdateHeader;
  String description = AppStrings.appUpdateDescription;

  @override
  Future<bool?> build() async {
    return null;
  }

  Future<bool?> getAppVersionData({String? userType}) async {
    try {
      final appCheckRepo = ref.read(appUpdateCheckRepoProvider);
      if (userType == null) {
        return false;
      }
      final response = await appCheckRepo.getAppCheckData(
          userType, Platform.isAndroid ? 'android' : 'ios');
      if (response != null &&
          response.data != null &&
          response.data['data'] != null &&
          response.data['data']['version'] != null) {
        if (response.data['data']['title'] != null) {
          header = response.data['data']['title'];
        }
        if (response.data['data']['description'] != null) {
          description = response.data['data']['description'];
        }

        final forceUpdate = response.data['data']['forceUpdate'] ?? false;
        String? appVersionFromAPIStr = response.data['data']['version'];
        String localAppVersionStr = await AppInfo.getAppVersion();

        if (appVersionFromAPIStr == null) {
          return false;
        }
        final appVersionFromAPI =
            _getExtendedVersionNumber(appVersionFromAPIStr);
        final localAppVersion = _getExtendedVersionNumber(localAppVersionStr);

        if (forceUpdate && localAppVersion < appVersionFromAPI) {
          // if (localAppVersion < appVersionFromAPI) {
          return true;
        }
      }

      return false;
    } catch (e, _) {
      return false;
    }
  }

  int _getExtendedVersionNumber(String version) {
    List versionCells = version.split('.');
    versionCells = versionCells.map((i) => int.parse(i)).toList();
    return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
  }

  Future<AppUpdateResult?> launchAppUpdate(Uri androidUrl, Uri iosUrl) async {
    try {
      if (Platform.isAndroid) {
        AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();
        if (updateInfo.updateAvailability ==
            UpdateAvailability.updateAvailable) {
          if (updateInfo.immediateUpdateAllowed) {
            // If an immediate update is available, perform it
            final v = await _performImmediateUpdate();
            print("inappupdatev $v");

            if (v == AppUpdateResult.inAppUpdateFailed) {
              launchUrl(Platform.isAndroid ? androidUrl : iosUrl);
            }
            return v;
          } else {
            // Start a flexible update if allowed
            await _startFlexibleUpdate();
            return null;
          }
        }
        // Notify the user that no updates are available
        return null;
      } else {
        launchUrl(iosUrl);
        return null;
      }
    } catch (_) {
      launchUrl(Platform.isAndroid ? androidUrl : iosUrl);
      return null;
    }
  }

  Future<AppUpdateResult> _performImmediateUpdate() async {
    try {
      return await InAppUpdate.performImmediateUpdate();
    } catch (e) {
      print('Immediate update failed: $e');
      return AppUpdateResult.inAppUpdateFailed;
    }
  }

  Future<void> _startFlexibleUpdate() async {
    try {
      await InAppUpdate.startFlexibleUpdate();
      await InAppUpdate.completeFlexibleUpdate();
    } catch (e) {
      print('Flexible update failed: $e');
    }
  }

  Future<AppUpdateResult?> updateApp(String androidId, String iosId) async {
    final androidUrl =
        Uri.https('play.google.com', '/store/apps/details', {'id': androidId});
    final iosUrl = Uri.https('apps.apple.com', '/app/id$iosId');
    return await launchAppUpdate(androidUrl, iosUrl);
  }

  // You can now update specific apps by calling the unified method.
  Future<AppUpdateResult?> updateTruepalPartner() async {
    return await updateApp('com.thetruepal.partner', '6468958746');
  }

  Future<AppUpdateResult?> updateTruepalMember() async {
    return await updateApp('com.thetruepal.member', '6471001802');
  }

  Future<AppUpdateResult?> updateTruefin() async {
    return await updateApp('com.thetruefin.mobile', '6478929485');
  }
}
