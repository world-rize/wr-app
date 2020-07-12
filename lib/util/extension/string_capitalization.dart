// Copyright © 2020 WorldRIZe. All rights reserved.

extension StringExtension on String {
  String capitalize() {
    return this[0].toUpperCase() + substring(1);
  }
}
