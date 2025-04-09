import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

enum Routes {
  home,
  ;

  String get path => switch (this) {
        home => '/',
        // ignore: unreachable_switch_case
        _ => '/$name',
      };

  Future<T?>? push<T extends Object?>([Object? extra]) =>
      rootNavigatorKey.currentContext?.push(
        path,
        extra: extra,
      );
}
