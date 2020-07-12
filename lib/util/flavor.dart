// Copyright © 2020 WorldRIZe. All rights reserved.

/// Flavor
enum Flavor {
  development,
  staging,
  production,
}

extension FlavorExtension on Flavor {
  String toShortString() {
    return toString().split('.').last;
  }
}
