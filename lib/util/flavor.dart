// Copyright © 2020 WorldRIZe. All rights reserved.

/// app flavors
enum Flavor {
  /// Development
  ///
  development,

  /// Staging
  ///
  staging,

  /// Production
  ///
  production,
}

extension FlavorExtension on Flavor {
  String toShortString() {
    return toString().split('.').last;
  }
}
