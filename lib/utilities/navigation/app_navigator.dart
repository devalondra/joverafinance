import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;

class AppNavigator {
  static final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  static NavigatorState? get _navigator => key.currentState;

  static BuildContext? get context => key.currentContext;

  static Future<T?> push<T>(Widget page) {
    return _navigator!.push<T>(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  static Future<T?> pushReplacement<T, TO>(Widget page) {
    return _navigator!.pushReplacement<T, TO>(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  static Future<T?> pushAndRemoveUntil<T>(Widget page) {
    return _navigator!.pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  static void pop<T extends Object?>([T? result]) {
    _navigator?.pop<T>(result);
  }

  static Future<T?> showDialog<T>({
    required WidgetBuilder builder,
    bool barrierDismissible = true,
  }) {
    final BuildContext? ctx = context;
    if (ctx == null) return Future.value(null);
    return material.showDialog<T>(
      context: ctx,
      barrierDismissible: barrierDismissible,
      builder: builder,
    );
  }
}
