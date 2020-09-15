// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:heatmap_calendar/heatmap_calendar.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/presentation/user_notifier.dart';

class StreakView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final un = Provider.of<UserNotifier>(context);
    final heatMap = un.calcHeatMap(un.user.statistics.testResults);

    return HeatMapCalendar(
      input: heatMap,
      colorThresholds: {
        1: Colors.green[100],
        10: Colors.green[300],
        30: Colors.green[500]
      },
      monthsLabels: const [
        '',
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '10',
        '11',
        '12',
      ],
      squareSize: 14,
      textOpacity: 0,
      dayTextColor: Colors.grey,
    );
  }
}
