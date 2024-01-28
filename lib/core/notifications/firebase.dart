import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:timezone/timezone.dart' as tz;

class FirebaseNotifications {
  static final FirebaseNotifications instance =
      FirebaseNotifications._instance();

  FirebaseNotifications._instance();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static String? fcm;

  Future<String?> getFCM() async {
    fcm = await _firebaseMessaging.getToken();
    return fcm;
  }

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  showNotification(RemoteNotification? msg) async {
    AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'com.test.task',
      'Task',
      importance: Importance.max,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'com.test.task',
      'Task',
      playSound: true,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.max,
    );
    DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        40, msg!.title, msg.body, platformChannelSpecifics,
        payload: null);
  }

  void iOSPermission() async {
    await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  void showMyNotification(RemoteMessage? m) {
    if (Platform.isIOS) {
      iOSPermission();
    }
    FlutterRingtonePlayer.play(
        android: AndroidSounds.notification, ios: IosSounds.glass);
    showNotification(m!.notification);
  }

  void initialFCM(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage m) {
      showMyNotification(m);
    });
  }

  void initialOpenedAppFCM(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage m) {
      showMyNotification(m);
    });
  }
}
