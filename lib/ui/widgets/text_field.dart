// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

Widget wrTextField({
  required Function(String) onChanged,
  required String hintText,
}) {
  return TextField(
    onChanged: onChanged,
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: hintText,
    ),
  );
}
