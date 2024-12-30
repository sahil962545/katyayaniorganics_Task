import 'dart:math';

import 'package:bloc_clean_coding/services/storage/local_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final LocalStorage localStorage = LocalStorage();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('user grant permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('user granted provisional premission');
      }
    } else {
      if (kDebugMode) {
        print('user denied permission');
      }
    }
  }

  Future<void> getDeviceToken() async {
    String? token = await messaging.getToken();
    localStorage.setValue('deviceToken', token ?? "");
  }

  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/launcher_icon');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {},
    );
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) async {
      if (kDebugMode) {
        print(message.notification!.title.toString());
      }
      if (kDebugMode) {
        print(message.notification!.body.toString());
      }
      showNotification(message);
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
        'High Importance Notification');
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            channel.id.toString(), channel.name.toString(),
            channelDescription: 'your channel descrition',
            importance: Importance.max,
            priority: Priority.max,
            ticker: 'ticker');
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
            presentAlert: true, presentSound: true, presentBadge: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          1234,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

  isTokenRefersh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }
}
