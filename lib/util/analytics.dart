// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_it/get_it.dart';
import 'package:wr_app/util/logger.dart';

enum AnalyticsEvent {
  logIn,
  doTest,
  finishTest,
  pointGet,
  upGrade,
  visitLesson,
}

Future<void> sendEvent({
  @required AnalyticsEvent event,
  Map<String, dynamic> parameters = const {},
}) async {
  final eventName = event.toString().split('.')[1];
  final analytics = GetIt.I<FirebaseAnalytics>();
  final params = parameters.entries
      .map((e) => '${e.key}: ${e.value.toString()}')
      .join(', ');
  InAppLogger.debug('[FirebaseAnalytics] $eventName $params');
  await analytics.logEvent(name: eventName, parameters: parameters);
}
