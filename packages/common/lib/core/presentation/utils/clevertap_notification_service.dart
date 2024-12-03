/*
import 'dart:io';

import 'package:clevertap_plugin/clevertap_plugin.dart';

class CleverTapNotificationService {
  static CleverTapNotificationService? instance;
  static CleverTapPlugin? _clevertapPlugin;

  CleverTapNotificationService._();

  factory CleverTapNotificationService() {
    if (instance == null) {
      instance = CleverTapNotificationService._();
      _clevertapPlugin ??= CleverTapPlugin();
    }
    return instance!;
  }

  Future<void> init(
      String channelId, String channelName, String channelDescription,
      {int? importance,
      bool? showBadge,
      Function(Map<String, dynamic>)? handler}) async {
    askPermission();
    CleverTapPlugin.setDebugLevel(3);
    if (Platform.isAndroid) {
      _handleForegroundStateNotificationInteraction(handler);
      _handleKilledStateNotificationInteraction(handler);
    }
    await createNotificationChannel(channelId, channelName, channelDescription,
        importance: importance, showBadge: showBadge);
    await CleverTapPlugin.initializeInbox();
    await CleverTapPlugin.registerForPush(); //only for iOS
  }

  CleverTapPlugin get getCleverTapInstance {
    return _clevertapPlugin!;
  }

  int highPriority = 3;
  // create notification channel
  Future<void> createNotificationChannel(
      String channelId, String channelName, String channelDescription,
      {int? importance, bool? showBadge}) async {
    await CleverTapPlugin.createNotificationChannel(channelId, channelName,
        channelDescription, importance ?? highPriority, showBadge ?? true);
  }

  void askPermission() async {
    bool? isPushPermissionEnabled =
        await CleverTapPlugin.getPushNotificationPermissionStatus();
    if (isPushPermissionEnabled == null) return;
    if (!isPushPermissionEnabled) {
      // var pushPrimerJSON = {
      //   'inAppType': 'alert',
      //   // 'inAppType': 'half-interstitial',
      //   'titleText': 'Get Notified',
      //   'messageText':
      //       'Please allow this to keep you updated with notifications.',
      //   'followDeviceOrientation': true,
      //   'positiveBtnText': 'Allow',
      //   'negativeBtnText': 'Cancel',
      //   'fallbackToSettings': false
      // };
      // CleverTapPlugin.promptPushPrimer(pushPrimerJSON);
      CleverTapPlugin.promptForPushNotification(false);
    }
  }

  void _handleKilledStateNotificationInteraction(
      Function(Map<String, dynamic>)? handler) async {
    // Retrieve the notification-payload in a 'CleverTapAppLaunchNotification' class object
    // which caused the application to open from a terminated state.
    CleverTapAppLaunchNotification appLaunchNotification =
        await CleverTapPlugin.getAppLaunchNotification();
    if (appLaunchNotification.didNotificationLaunchApp) {
      //App is launched from a notification click which was rendered by the CleverTap SDK.
      if (appLaunchNotification.payload != null) {
        Map<String, dynamic> notificationPayload =
            appLaunchNotification.payload!;
        handler?.call(notificationPayload);
      }
    }
  }

  void _handleForegroundStateNotificationInteraction(
      Function(Map<String, dynamic>)? handler) {
    if (handler != null) {
      _clevertapPlugin?.setCleverTapPushClickedPayloadReceivedHandler(handler);
    }
  }

  Future<String?> getCleverTapId() async {
    String? id = await CleverTapPlugin.getCleverTapID();
    return id;
  }

  /// this method should be called once at time authentication
  // static void setUser(String token) {
  void setPushToken(String token) {
    CleverTapPlugin.setPushToken(token);
  }
}
*/
