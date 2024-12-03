import 'package:common/core/infrastructure/local_storage_data_source/secure_keys.dart';
import 'package:common/core/infrastructure/local_storage_data_source/secure_storage.dart';
import 'package:common/features/login_signup/infrastructure/data_sources/login_remote_data_source.dart';
import 'package:common/features/login_signup/presentation/providers/notifiers/is_login_sign_status.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:universal_html/html.dart' as uni;

part 'cookie_check_notifier.g.dart';

@Riverpod(keepAlive: true)
class CookieCheckNotifier extends _$CookieCheckNotifier {
  @override
  FutureOr<bool> build() async {
    return await checkForCookieForMWeb();
  }

  //checks the browser cookie if any and sets in flutter app
  Future<bool> checkForCookieForMWeb() async {
    if (kIsWeb == false) return true;
    final token = await SecureStorage().getPref(key: SecureKeys.accessToken);
    if (token == null) {
      String myCookie = uni.document.cookie ?? "";
      List<String> cookieList = myCookie.split('; ');
      bool isAccessCookieSet = false;
      bool isRefreshCookieSet = false;
      for (String cookie in cookieList) {
        List<String> keyValue = cookie.split('=');
        if (keyValue.length == 2) {
          if (keyValue[0] == "token") {
            await SecureStorage()
                .setPref(key: SecureKeys.accessToken, value: keyValue[1]);
            isAccessCookieSet = true;
          }
          if (keyValue[0] == "refreshToken") {
            await SecureStorage()
                .setPref(key: SecureKeys.refreshToken, value: keyValue[1]);
            isRefreshCookieSet = true;
          }
        }
      }
      if (isAccessCookieSet && isRefreshCookieSet) {
        await ref.read(loginSignUpDataSourceProvider).getMemberInfo();
        ref.refresh(loginStatusProvider);
      }
    }
    return true;
  }

  clearCookieInBrowser() async {
    if (kIsWeb == false) return;
    String myCookie = uni.document.cookie ?? "";
    if (myCookie.contains("token=")) {
      uni.document.cookie = "token=; path=/; domain=.thetruefin.com; ";
      uni.document.cookie = "refreshToken=; path=/; domain=.thetruefin.com; ";
    }
  }

  //sets the cookie in browser from flutter app
  setCookieInBrowser() async {
    if (kIsWeb == false) return;
    /* String myCookie = uni.document.cookie ?? "";
    if (myCookie.contains("token=")) return; //token already set*/
    String? token = await SecureStorage().getPref(key: SecureKeys.accessToken);
    String? refreshToken =
        await SecureStorage().getPref(key: SecureKeys.refreshToken);
    uni.document.cookie = "token=$token; path=/; domain=.thetruefin.com; ";
    uni.document.cookie =
        "refreshToken=$refreshToken; path=/; domain=.thetruefin.com; ";
  }
}
