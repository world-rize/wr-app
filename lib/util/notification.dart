// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:async';

import 'package:data_classes/data_classes.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wr_app/util/logger.dart';

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  const ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}

class AppNotifier {
  /// シングルトンインスタンス
  static AppNotifier _cache;

  static const MethodChannel _platform =
      MethodChannel('crossingthestreams.io/resourceResolver');

  factory AppNotifier() {
    return _cache ??= AppNotifier._internal();
  }

  AppNotifier._internal() {
    _requestIOSPermissions();
    _configureDidRecieveLocalNotificationSubject();
    _configureSelectNotificationSubject();

    InAppLogger.log('✨ init Notifier');
  }

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationAppLaunchDetails _notificationAppLaunchDetails;

  /// notification stream
  final StreamController<ReceivedNotification>
      didReceiveLocalNotificationSubject =
      StreamController<ReceivedNotification>();

  /// notification subject?
  final StreamController<String> selectNotificationSubject =
      StreamController<String>();

  void _requestIOSPermissions() {
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  /// didReceiveLocalNotificationSubject を subscribe
  void _configureDidRecieveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      InAppLogger.log('Hello', type: 'notice');
    });
  }

  /// selectNotificationSubject を subscribe
  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      InAppLogger.log('payload: $payload', type: 'notice');
    });
  }

  /// notification
  Future<void> showNotification(
      {String title, String body, String payload}) async {
//    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
//        'channel id', 'channel name', 'channel description',
//        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    final iOSPlatformChannelSpecifics = IOSNotificationDetails();
    final platformChannelSpecifics =
        NotificationDetails(null, iOSPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: payload);
  }

  /// schedules notification
  Future<void> scheduleNotification({DateTime time}) async {
    final scheduledNotificationDateTime =
        DateTime.now().add(Duration(seconds: 5));

//    var vibrationPattern = Int64List(4);
//    vibrationPattern[0] = 0;
//    vibrationPattern[1] = 1000;
//    vibrationPattern[2] = 5000;
//    vibrationPattern[3] = 2000;

//    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//        'your other channel id',
//        'your other channel name',
//        'your other channel description',
//        icon: 'secondary_icon',
//        sound: RawResourceAndroidNotificationSound('slow_spring_board'),
//        largeIcon: DrawableResourceAndroidBitmap('sample_large_icon'),
//        vibrationPattern: vibrationPattern,
//        enableLights: true,
//        color: const Color.fromARGB(255, 255, 0, 0),
//        ledColor: const Color.fromARGB(255, 255, 0, 0),
//        ledOnMs: 1000,
//        ledOffMs: 500);
    var iOSPlatformChannelSpecifics =
        IOSNotificationDetails(sound: 'slow_spring_board.aiff');
    var platformChannelSpecifics =
        NotificationDetails(null, iOSPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.schedule(
        0,
        'scheduled title',
        'scheduled body',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }
}
