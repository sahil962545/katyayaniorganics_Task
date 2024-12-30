 import 'dart:io';

import 'package:bloc_clean_coding/utils/notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

NotificationService notificationService = NotificationService();
  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      if (Platform.isAndroid) {
        notificationService.initLocalNotification(context, message);
        notificationService.showNotification(message);
      }
    });
  }