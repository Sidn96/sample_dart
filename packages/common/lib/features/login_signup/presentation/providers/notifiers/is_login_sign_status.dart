import 'package:common/core/infrastructure/dtos/user_info_dto.dart';
import 'package:common/core/infrastructure/local/store_local_preference.dart';
import 'package:common/core/infrastructure/local_storage_data_source/secure_keys.dart';
import 'package:common/core/infrastructure/local_storage_data_source/secure_storage.dart';
import 'package:common/core/presentation/providers/pop_util_route.dart';
import 'package:common/core/presentation/routing/global_navigation_utils.dart';
import 'package:common/core/presentation/services/moengage_service_truefin.dart';
import 'package:common/core/presentation/utils/extensions/string_extension.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/mo_engage_events_const.dart';
import 'package:common/features/blogs/presentation/providers/blog_cards_provider.dart';
import 'package:common/features/login_signup/presentation/providers/login_provider.dart';
import 'package:common/features/login_signup/presentation/providers/notifiers/cookie_check_notifier.dart';

import '../../../../profile/presentation/common_imports.dart';

part 'is_login_sign_status.g.dart';

@Riverpod(keepAlive: true)
class LoginStatus extends _$LoginStatus {
  UserData? userInfoData;

  @override
  Future<bool> build() async {
    String? token;
    try {
      token = await SecureStorage().getPref(key: SecureKeys.accessToken);
    } catch (e) {}
    userInfoData = (await ref.read(getUserStoredDataProvider.future))?.data;
    // updateState();
    return token.isNotNullNorEmpty();
  }

  Future<bool> checkIfLoggedIn() async {
    String? token = await SecureStorage().getPref(key: SecureKeys.accessToken);
    return token.isNotNullNorEmpty();
  }

  Future<void> fetchUserInfoData() async {
    userInfoData = (await ref.read(getUserStoredDataProvider.future))?.data;
  }

  String? getEmail() {
    // return ref.read(loginStatusProvider.notifier).userInfoData?.contactNo;
    return userInfoData?.personalEmail;
  }

  String? getMobileNumber() {
    // return ref.read(loginStatusProvider.notifier).userInfoData?.contactNo;
    return userInfoData?.contactNo;
  }

  String getUserName({String defaultName = 'Guest'}) {
    var fullName =
        ref.read(loginStatusProvider.notifier).userInfoData?.fullName;
    if (fullName.isNotNullNorEmpty()) {
      return fullName!.split(" ").first;
    }
    return defaultName;
  }

  void logout() async {
    MoEngageService().trackEvent(
      eventName: MoEngageEventsConsts.eventsNames.memberLogoutsuccessful,
      product: ProductEvent.truefin,
    );
    MoEngageService().logoutMoEngage();
    SecureStorage().deleteAllPref();
    //clear blogs cache
    ref.read(blogCardsStateNotifierProvider.notifier).clearBlogsPrefs();
    ref.read(cookieCheckNotifierProvider.notifier).clearCookieInBrowser();
    ref.read(localPreferenceProvider).clearAllPreference();
    state = const AsyncData(false);
    userInfoData = null;
    removeAndPushReplacementNamed(
        GlobalNavigationUtils.rootAppNavigatorKey.currentContext!, "/login");
  }

  // Future<void> updateState() async {
  //   // updating state because if user is loggedIn in SEO site and at a same time FlutterMWeb is also open
  //   // then MWeb is getting null as token but after some time token is not null
  //   // that's why i have added this update state function.
  //   await Future.delayed(const Duration(seconds: 3));
  //   String? token = await SecureStorage().getPref(key: SecureKeys.accessToken);
  //   state = AsyncValue.data(token.isNotNullNorEmpty());
  // }
}

@riverpod
class StartLoading extends _$StartLoading {
  @override
  bool build() {
    return false;
  }

  changeState(bool val) {
    state = val;
  }
}
