// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:math';

import 'package:flutter/material.dart';

/// 再生速度を変えるスライダー
class PitchSlider extends StatelessWidget {
  const PitchSlider({
    @required this.pitches,
    @required this.pitch,
    @required this.onChanged,
  });

  final List<double> pitches;
  final double pitch;
  final Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: pitch,
      min: pitches.reduce(min),
      max: pitches.reduce(max),
      divisions: pitches.length,
      label: pitch.round().toString(),
      onChanged: onChanged,
    );
  }
}
