import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;

class AppNavigator {
  static final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  static NavigatorState? get _navigator => key.currentState;

  static BuildContext? get context => key.currentContext;

  static PageRoute<T> _route<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: const Duration(milliseconds: 280),
      reverseTransitionDuration: const Duration(milliseconds: 220),
      transitionsBuilder: (_, animation, __, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 0.04),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    );
  }

  static Future<T?> push<T>(Widget page) {
    return _navigator!.push<T>(_route(page));
  }

  static Future<T?> pushReplacement<T, TO>(Widget page) {
    return _navigator!.pushReplacement<T, TO>(_route(page));
  }

  static Future<T?> pushAndRemoveUntil<T>(Widget page) {
    return _navigator!.pushAndRemoveUntil<T>(_route(page), (route) => false);
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
