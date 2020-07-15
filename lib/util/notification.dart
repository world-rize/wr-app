// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:async';

import 'package:data_classes/data_classes.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ReceivedNotification {
  const ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}

// TODO(some): refactoring
final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

NotificationAppLaunchDetails _notificationAppLaunchDetails;

// Streams are created so that app can respond to notification-related events since the plugin is initialised in the `main` function
final StreamController<ReceivedNotification>
    didReceiveLocalNotificationSubject =
    StreamController<ReceivedNotification>();

class AppNotifier {
  Future<void> setup() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        didReceiveLocalNotificationSubject.add(ReceivedNotification(
            id: id, title: title, body: body, payload: payload));
      },
    );
    final initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        print('notification payload: $payload');
      }
    });

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  static const MethodChannel _platform =
      MethodChannel('crossingthestreams.io/resourceResolver');

  /// notification stream
//  final StreamController<ReceivedNotification>
//      didReceiveLocalNotificationSubject =
//      StreamController<ReceivedNotification>();

  /// notification subject?
//  final StreamController<String> selectNotificationSubject =
//      StreamController<String>();

  void requestIOSPermissions() {
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  /// didReceiveLocalNotificationSubject を subscribe
//  void _configureDidRecieveLocalNotificationSubject() {
//    didReceiveLocalNotificationSubject.stream
//        .listen((ReceivedNotification receivedNotification) async {
//      InAppLogger.log('Hello', type: 'notice');
//    });
//  }
//
//  /// selectNotificationSubject を subscribe
//  void _configureSelectNotificationSubject() {
//    selectNotificationSubject.stream.listen((String payload) async {
//      InAppLogger.log('payload: $payload', type: 'notice');
//    });
//  }

  /// notification
  Future<void> showNotification({
    @required String title,
    @required String body,
    @required String payload,
  }) async {
//    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
//        'channel id', 'channel name', 'channel description',
//        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    final iOSPlatformChannelSpecifics = IOSNotificationDetails();
    final platformChannelSpecifics =
        NotificationDetails(null, iOSPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: payload);
  }

//  /// schedules notification
//  Future<void> scheduleNotification({DateTime time}) async {
//    final scheduledNotificationDateTime =
//        DateTime.now().add(Duration(seconds: 5));
//
////    var vibrationPattern = Int64List(4);
////    vibrationPattern[0] = 0;
////    vibrationPattern[1] = 1000;
////    vibrationPattern[2] = 5000;
////    vibrationPattern[3] = 2000;
//
////    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
////        'your other channel id',
////        'your other channel name',
////        'your other channel description',
////        icon: 'secondary_icon',
////        sound: RawResourceAndroidNotificationSound('slow_spring_board'),
////        largeIcon: DrawableResourceAndroidBitmap('sample_large_icon'),
////        vibrationPattern: vibrationPattern,
////        enableLights: true,
////        color: const Color.fromARGB(255, 255, 0, 0),
////        ledColor: const Color.fromARGB(255, 255, 0, 0),
////        ledOnMs: 1000,
////        ledOffMs: 500);
//    var iOSPlatformChannelSpecifics =
//        IOSNotificationDetails(sound: 'slow_spring_board.aiff');
//    var platformChannelSpecifics =
//        NotificationDetails(null, iOSPlatformChannelSpecifics);
//    await _flutterLocalNotificationsPlugin.schedule(
//        0,
//        'scheduled title',
//        'scheduled body',
//        scheduledNotificationDateTime,
//        platformChannelSpecifics);
//  }
}
