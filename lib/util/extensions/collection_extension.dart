// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:math';

extension IndexedMap<T, E> on List<T> {
  /// enumerate
  List<E> indexedMap<E>(E Function(int index, T item) function) {
    final list = <E>[];
    asMap().forEach((index, element) {
      list.add(function(index, element));
    });
    return list;
  }

  /// select random [count] elements from the list
  List<T> sample(int count) {
    final result = <T>[];
    for (var i = 0; i < count; i++) {
      result.add(this[Random().nextInt(length)]);
    }
    assert(result.length == count);
    return result;
  }
}
