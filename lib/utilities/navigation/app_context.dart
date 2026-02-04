import 'package:flutter/material.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';

class AppContext {
  static BuildContext? get context => AppNavigator.context;

  static MediaQueryData? get _mediaQuery {
    final BuildContext? ctx = context;
    if (ctx == null) return null;
    return MediaQuery.of(ctx);
  }

  static double get width => _mediaQuery?.size.width ?? 0;

  static double get height => _mediaQuery?.size.height ?? 0;

  static ThemeData? get _theme {
    final BuildContext? ctx = context;
    if (ctx == null) return null;
    return Theme.of(ctx);
  }

  static TextTheme get textTheme => _theme?.textTheme ?? const TextTheme();
}
