// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../utils/stringGlobal.dart';

class FCMController extends GetxController {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final messagging = FirebaseMessaging.instance;
  List<String>? userFCMToken;
  Map<String, dynamic>? notificationData;

  @override
  Future<void> onInit() async {
    super.onInit();
    messagging.requestPermission();
    messagging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen(_handleMessage);
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);

    String? token = await messagging.getToken();

    log('FCM Token: $token');

    String email = auth.currentUser!.email!;
    var user = firestore.collection('Users').doc(email);

    if (token != null) {
      await user.update(
        {'fcmToken': token},
      );
    }
    // sendNotificationToAllUser(titleNotif, messageNotif);
  }

  Future<void> _handleMessage(RemoteMessage message) async {
    if (kDebugMode) {
      print('Received message: ${message.notification?.body}');
    }

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const androidInitializeSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings =
        InitializationSettings(android: androidInitializeSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
    );
    notificationData = message.data;
  }

  Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    if (kDebugMode) {
      print('Received background message: ${message.notification?.body}');
    }

    if (message != null) {
      notificationData = message.data;
    } else {}
  }

  Future<List<String>> getAllUserToken() async {
    List<String>? userFCMToken = [];
    var snapshot = await firestore
        .collection('Users')
        .where('role', isEqualTo: 'user')
        .get();
    var document = snapshot.docs;
    for (var doc in document) {
      var token = doc.data()['fcmToken'];
      if (kDebugMode) {
        print('ALL PEGAWAI TOKEN EMAIL : ${doc.data()['email']}');
        print('ALL PEGAWAI TOKEN : ${doc.data()['fcmToken']}');
      }
      if (token != null) {
        userFCMToken.add(token);
      }
    }

    return userFCMToken;
  }

  Future<void> sendNotificationToAllUser(String title, String message) async {
    List<String> userToken = await getAllUserToken();
    for (var token in userToken) {
      log('ALL PEGAWAI AS USER TOKEN : $token');
    }

    Dio dio = Dio();
    try {
      Map<String, dynamic> data = {
        'notification': {
          'title': title,
          'body': message,
        },
        'priority': 'high',
        'data': {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          'status': 'done',
        },
        'registration_ids': userToken,
      };

      Options options = Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
      );

      var response = await dio.post(
        'https://fcm.googleapis.com/fcm/send',
        data: data,
        options: options,
      );

      if (response.statusCode == 200) {
        // Request successful
        if (kDebugMode) {
          print('Notification sent successfully');
        }
      } else {
        // Request failed
        if (kDebugMode) {
          print(
              'Failed to send notification. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      // Exception occurred during the request
      if (kDebugMode) {
        print('Error sending notification: $e');
      }
    }
  }

  void notificationRequestDaily() {
    DateTime now = DateTime.now();

    DateTime scheduledTime = DateTime(now.year, now.month, now.day, 6);

    Duration difference = scheduledTime.difference(now);

    int dayOfWeek = now.weekday;

    if (dayOfWeek == DateTime.sunday || now.hour >= 6) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
      difference = scheduledTime.difference(now);
    }

    Timer(difference, () {
      sendNotificationToAllUser(titleNotif, messageNotif);
    });
  }
}
