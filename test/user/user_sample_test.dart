// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:test/test.dart';
import 'package:wr_app/domain/user/model/user.dart';

void main() {
  group('User Test', () {
    test('Init', () {
      final user = User.dummy();

      expect(user.name, 'dummy');
    });
  });
}
