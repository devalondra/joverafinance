import 'package:flutter/material.dart';

class AppMessenger {
  static final GlobalKey<ScaffoldMessengerState> key =
      GlobalKey<ScaffoldMessengerState>();

  static void showSnackBar(SnackBar snackBar) {
    key.currentState?.showSnackBar(snackBar);
  }

  static void hideCurrentSnackBar() {
    key.currentState?.hideCurrentSnackBar();
  }
}
