// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

enum Flavor {
  development,
  staging,
  production,
}

class FlavorProvider extends InheritedWidget {
  FlavorProvider({
    Key key,
    @required this.flavor,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);
  final Flavor flavor;

  static Flavor of(BuildContext context) =>
      (context.getElementForInheritedWidgetOfExactType().widget
              as FlavorProvider)
          .flavor;

  @override
  bool updateShouldNotify(FlavorProvider oldWidget) => false;
}
