import 'dart:io';

import 'package:common/core/infrastructure/local_storage_data_source/secure_keys.dart';
import 'package:common/core/infrastructure/local_storage_data_source/secure_storage.dart';
import 'package:common/core/infrastructure/network/main_api/main_api_config.dart';
import 'package:common/core/presentation/utils/app_info.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/mo_engage_events_const.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:moengage_flutter/moengage_flutter.dart';
import 'package:snowplow_tracker/snowplow_tracker.dart';

class MoEngageService {
  static late MoEngageFlutter _moengagePlugin;
  static MoEngageService instance = MoEngageService._();
  // snowplow tracker
  static SnowplowTracker? _tracker;

  String? deviceType;

  String versionNo = "";

  factory MoEngageService() => instance;

  MoEngageService._() {
    // TODO: QA BUILD DEBUG Key: D3MV8M3DOT6Y33APOZFZ5CES_DEBUG
    _moengagePlugin = MoEngageFlutter(MainApiConfig.moengageKey,
        moEInitConfig: MoEInitConfig(
            pushConfig: PushConfig(
          shouldDeliverCallbackOnForegroundClick: true,
        )));
  }

  /// Initialise MoEngage SDK
  Future<void> initSDK() async {
    _moengagePlugin.initialise();
    await snowPlowInit();
  }

  void logoutMoEngage() {
    _moengagePlugin.logout();
  }

  void moengageTrackEvent(
      {required String eventName,
      required String product,
      Map<String, dynamic>? properties}) {
    // initialise [MoEProperties]
    MoEProperties moProperties = MoEProperties();
    // add dynamic attributes
    if (properties != null) {
      for (var item in properties.entries) {
        moProperties.addAttribute(item.key, item.value);
      }
    }

    _moengagePlugin.trackEvent(eventName, moProperties);
  }

  void npsTrackEvent(
    String eventName, {
    Map<String, dynamic>? properties,
  }) {
    trackEvent(
        product: ProductEvent.nps,
        eventName: eventName,
        properties: properties);
  }

  void resetCurrentContext() {
    _moengagePlugin.resetCurrentContext();
  }

  ///ToDo: need to reset context before setting new context but for now 'Arsuh(Mo-engage team)' told remove resetContext.
  //need to set the context for a screen on which you need to send in-app notifications
  void setCurrentContext(String screenName) {
    debugPrint(' setCurrentContext: $screenName');
    _moengagePlugin.setCurrentContext([screenName]);
    MoEngageService().showInApp();
  }

  void setEmailId(String emailId) {
    _moengagePlugin.setEmail(emailId);
  }

  void setUID(String memberId, String phoneNumber) {
    _moengagePlugin.setUniqueId(memberId);
    _moengagePlugin.setPhoneNumber(phoneNumber);
  }

  ///setup listeners
  /// call this in initState
  void setupListeners() {
    _moengagePlugin.setPushClickCallbackHandler((s) {
      _onPushClick(s);
    });
    /* _moengagePlugin.setInAppClickHandler(_onInAppClick);
    _moengagePlugin.setInAppShownCallbackHandler(_onInAppShown);
    _moengagePlugin.setInAppDismissedCallbackHandler(_onInAppDismiss);
    _moengagePlugin.setPushTokenCallbackHandler(_onPushTokenGenerated);*/
    _moengagePlugin.setPermissionCallbackHandler(_permissionCallbackHandler);
    _moengagePlugin.configureLogs(LogLevel.VERBOSE);
    setupNotifications();
    //showInApp();
  }

  void setupNotifications() async {
    if (kIsWeb) return;
    _moengagePlugin.requestPushPermissionAndroid();
    _moengagePlugin.registerForPushNotification();

    final token = await FirebaseMessaging.instance.getToken();
    if (token == null) return;
    _moengagePlugin.passFCMPushToken(token);
    //_moengagePlugin.pushPermissionResponseAndroid(true);
    _moengagePlugin.setupNotificationChannelsAndroid();
    debugPrint(
        ' Main : initService(): This is a to request permisssion $token');
    // _moengagePlugin.updatePushPermissionRequestCountAndroid(requestCount);
  }

  void setUserInstallApp() {
    _moengagePlugin.setAppStatus(MoEAppStatus.install);
  }

  void setUserUpdateApp() {
    _moengagePlugin.setAppStatus(MoEAppStatus.update);
  }

  //to show in-app notifications
  void showInApp() {
    _moengagePlugin.showInApp();
  }

  Future<void> snowPlowInit() async {
    try {
      _tracker = await Snowplow.createTracker(
        namespace: 'sp1',
        endpoint: MainApiConfig.snowPlowCollectorEndpoint,
        trackerConfig: const TrackerConfiguration(
          appId: 'com.thetruefin.mobile',
        ),
      );
    } catch (e) {
      debugPrint("failed to create Snowplow ");
    }
  }

  void snowplowTrackEvent(
      {required String eventName,
      required String product,
      Map<String, dynamic>? properties}) async {
    try {
      Map? deviceData;

      final appversion = await AppInfo.getAppInfo();
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (!kIsWeb && Platform.isIOS) {
        final iosData = await deviceInfo.iosInfo;
        deviceData = {
          "device_id": iosData.identifierForVendor,
          "os_version": iosData.systemVersion,
          "app_version": appversion,
          "device_make": iosData.name,
          "device_model": iosData.model,
        };
      } else if (!kIsWeb && Platform.isAndroid) {
        final androidData = await deviceInfo.androidInfo;
        deviceData = {
          "device_id": androidData.id,
          "os_version": androidData.version,
          "app_version": appversion,
          "device_make": androidData.device,
          "device_model": androidData.model,
        };
      }
      properties?.removeWhere((key, value) => (value == null || value == ""));
      properties?.removeWhere(
        (key, value) =>
            (key == "platform") ||
            (key == "device_type") ||
            (key == "operating_system") ||
            (key == "app_version"),
      );
      final event = {
        "name": eventName,
        "schema_version": 1.0,
        "create_time":
            "${DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now())}Z", // 2024-04-19 17:45:03
        "created_by": 'user',
        "uuid": deviceData?["device_id"] ?? "",
        "app": 'truefin',
        "module": product,
        "platform": kIsWeb
            ? "mweb"
            : defaultTargetPlatform == TargetPlatform.android
                ? 'android'
                : "ios",
        if (deviceData != null) "device": deviceData,
        "payload": properties,
      };
      event.removeWhere((key, value) => (value == null || value == ""));
      _tracker?.track(SelfDescribing(
          schema:
              "iglu:com.retire100/truefin_${product}_1-0-0/jsonschema/1-0-0",
          data: event));
    } catch (e) {
      print(e);
    }
  }

  // TODO: QA BUILD DEBUG Key: D3MV8M3DOT6Y33APOZFZ5CES_DEBUG
  void startMoGeofenceMonitoring() {
    //final MoEngageGeofence moEngageGeofence = MoEngageGeofence('D3MV8M3DOT6Y33APOZFZ5CES');
    // moEngageGeofence.startGeofenceMonitoring();
  }
  // TODO: QA BUILD DEBUG Key: D3MV8M3DOT6Y33APOZFZ5CES_DEBUG
  void stopMoGeofenceMonitoring() {
    // final MoEngageGeofence moEngageGeofence = MoEngageGeofence('D3MV8M3DOT6Y33APOZFZ5CES');
    // moEngageGeofence.stopGeofenceMonitoring();
  }
  void trackEvent({
    required String eventName,
    required ProductEvent product,
    Map<String, dynamic>? properties,
  }) async {
    try {
      debugPrint("EventName: $eventName :: Properties: $properties ");

      final payload = {...?properties};

      String version = await AppInfo.getAppVersion();
      String build = await AppInfo.getBuildNumber();
      versionNo = "$version+$build";
      var platformType = kIsWeb
          ? "mWeb"
          : defaultTargetPlatform == TargetPlatform.android
              ? 'android'
              : "ios";

      String? utmSource =
          await SecureStorage().getPref(key: SecureKeys.utmsource);
      String? utmMedium =
          await SecureStorage().getPref(key: SecureKeys.utmmedium);
      String? utmCampaign =
          await SecureStorage().getPref(key: SecureKeys.utmcampaign);
      String? utmContent =
          await SecureStorage().getPref(key: SecureKeys.utmcontent);

      var utmPayLoad = {
        "app_version": versionNo,
        "operating_system": defaultTargetPlatform.name,
        "utm_source": utmSource,
        "utm_medium": utmMedium,
        "utm_campaign": utmCampaign,
        "utm_content": utmContent,
        "device_type": deviceType,
        MoEngageEventsConsts.eventAttributesKey.platform: platformType,
      };

      payload.addAll(utmPayLoad);

      moengageTrackEvent(
          eventName: eventName, product: product.name, properties: payload);
      snowplowTrackEvent(
          eventName: eventName, product: product.name, properties: payload);
    } catch (_) {}
  }

  void _onInAppClick(ClickData message) {
    debugPrint(
        ' Main : _onInAppClick() : This is a inapp click callback from native to flutter. Payload $message');
  }

  void _onInAppDismiss(InAppData message) {
    debugPrint(
        ' Main : _onInAppDismiss() : This is a callback on inapp dismiss from native to flutter. Payload $message');
  }

  void _onInAppShown(InAppData message) {
    debugPrint(
        ' Main : _onInAppShown() : This is a callback on inapp shown from native to flutter. Payload $message');
  }

  void _onPushClick(PushCampaignData message) {
    debugPrint(
        ' Main : _onPushClick(): This is a push click callback from native to flutter. Payload $message');
    /*if (message.data.selfHandledPushRedirection) {
    handleDeeplink(message.data.payload, ref: ref);
     }*/
  }

  void _onPushTokenGenerated(PushTokenData pushToken) {
    debugPrint(
        ' Main : _onPushTokenGenerated() : This is callback on push token generated from native to flutter: PushToken: $pushToken');
  }

  void _permissionCallbackHandler(PermissionResultData data) {
    debugPrint(' Permission Result: ${data.platform.name}');
    if (data.platform.name.contains("android")) {
      _moengagePlugin.pushPermissionResponseAndroid(data.isGranted);
    }
  }
}
