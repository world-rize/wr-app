// Copyright © 2020 WorldRIZe. All rights reserved.

enum BuildMode { profile, debug, release }

/// distinct build mode
BuildMode buildMode = () {
  if (const bool.fromEnvironment('dart.vm.product')) {
    return BuildMode.release;
  }

  var result = BuildMode.profile;

  assert(() {
    result = BuildMode.debug;
    return true;
  }());

  return result;
}();
