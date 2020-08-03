// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_it/get_it.dart';

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
  await analytics.logEvent(name: eventName, parameters: parameters);
}
