import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'log_print.dart';

class NotificationService {
  late final FirebaseMessaging _messaging;
  AndroidNotificationChannel? channel;

  bool isFlutterLocalNotificationsInitialized = false;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // create notification channel
  Future<void> createNotificationChannel(
      String channelId, String channelName, String? channelDescription) async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    channel = AndroidNotificationChannel(
        channelId, // id
        channelName, // title
        description: channelDescription,
        importance: Importance.high,
        enableLights: true);

    if (channel != null) {
      return;
    }
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .createNotificationChannel(channel!);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    isFlutterLocalNotificationsInitialized = true;
  }

  /// register notification
  Future<void> registerNotification(String channelId, String channelName,
      {String? channelDescription,
      required String icon,
      Function(String?)? onSelectNotification,
      Function(RemoteMessage?)? onData}) async {
    // Initialize the Firebase app
    await Firebase.initializeApp();

    // Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    if (!kIsWeb) {
      await createNotificationChannel(
          channelId, channelName, channelDescription);
      // final android = AndroidInitializationSettings(icon);
      // const iOS = IOSInitializationSettings();
      // final initSettings = InitializationSettings(android: android, iOS: iOS);

      // await flutterLocalNotificationsPlugin.initialize(initSettings,
      //     onSelectNotification: onSelectNotification);
    }
    // On iOS, this helps to take the user permissions
    // await _messaging.requestPermission(
    //     alert: true, badge: true, provisional: false, sound: true);

    // handleNotification(channelId, channelName,
    //     channelDescription: channelDescription, icon: icon, onData: onData);
  }

  Future<void> handleNotification(String channelId, String channelName,
      {String? channelDescription,
      required String icon,
      Function(RemoteMessage?)? onData}) async {
    // On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
        alert: true, badge: true, provisional: false, sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // For handling the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Parse the message received
        PushNotification notification = PushNotification(
          dataTitle: message.data['title'],
          dataBody: message.data['body'],
        );

        logPrint('payload object: ${message.notification} ${message.data}');
        showNotificationCustomSound(channelId, channelName,
            channelDescription: channelDescription,
            icon: icon,
            title: notification.dataTitle,
            body: notification.dataBody);
      });

      FirebaseMessaging.onMessageOpenedApp.listen(onData);
      // await FirebaseMessaging.instance.getInitialMessage().then((v) {
      //   return onData?.call(v);
      // });
    }
  }

  /// get token
  Future<String?> getToken() async {
    //If subscribe based sent notification then use this token
    final fcmToken = await _messaging.getToken();
    return fcmToken;
  }

  Future<RemoteMessage?> handleNavigationFromBackground() async {
    return await _messaging.getInitialMessage();
  }

  Future<void> showNotificationCustomSound(String channelId, String channelName,
      {String? channelDescription,
      required String icon,
      String? title,
      String? body}) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channelId, // id
      channelName, // title
      importance: Importance.high,
      enableLights: true,
      channelDescription: channelDescription,
      icon: icon,
      color: Colors.black,
      styleInformation: const BigTextStyleInformation(''),
      // sound: RawResourceAndroidNotificationSound('slow_spring_board'),
    );
    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
            // sound: 'slow_spring_board.aiff'
            );
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
    logPrint('payload object: $title $body');
    await flutterLocalNotificationsPlugin.show(
        generateUniqueId(), title, body, notificationDetails);
  }

  int generateUniqueId() {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    logPrint('generateUniqueId', message: id.toString());
    return id;
  }
}

class PushNotification {
  PushNotification({
    this.dataTitle,
    this.dataBody,
  });

  String? dataTitle;
  String? dataBody;
}
