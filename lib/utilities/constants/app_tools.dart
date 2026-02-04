import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_enums.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';
import 'package:jovera_finance/utilities/navigation/app_context.dart';
import 'package:jovera_finance/utilities/navigation/app_messenger.dart';

class AppTools {
  Future<String>? getFCMTokenForDevice() async {
    try {
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      debugPrint(fcmToken ?? "");
      return fcmToken ?? "";
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return "";
    }
  }

  void showSnackBar(
    String message,
    SnackEnum snackEnum,
    int seconds, {
    Function()? onTap,
  }) {
    final SnackBar snackBar = SnackBar(
      content: Text(
        message,
        style: AppContext.textTheme.labelLarge?.copyWith(
          color: AppColors.white,
        ),
      ),
      backgroundColor:
          snackEnum == SnackEnum.success
              ? AppColors.primary
              : snackEnum == SnackEnum.error
              ? AppColors.textGrey
              : AppColors.primaryLight,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 5),
      action: SnackBarAction(
        label: 'dismiss'.tr,
        textColor: Colors.white,
        onPressed: onTap ?? () {},
      ),
    );

    Future.delayed(Duration(seconds: seconds), () {
      AppMessenger.showSnackBar(snackBar);
    });
  }

  void showSuccessSnackBar(String message, {int timer = 0}) {
    showSnackBar(message.tr, SnackEnum.success, timer);
  }

  void showErrorSnackBar(String message, {int timer = 0}) {
    showSnackBar(message.tr, SnackEnum.error, timer);
  }

  void showWarningSnackBar(String message, {int timer = 0}) {
    showSnackBar(message.tr, SnackEnum.warning, timer);
  }

  String? errorMessage(error) {
    if (error.response != null) {
      if (error.response?.data != null) {
        if (error.response?.data is String) {
          return jsonDecode(error.response.toString()) == null
              ? null
              : jsonDecode(error.response.toString())['message'];
        } else {
          return "Something went wrong. Please check your connection";
        }
      } else if (error.response?.data is Map<String, dynamic>) {
        return error.response?.data['message'];
      } else {
        return "Something went wrong. Please try again later";
      }
    } else {
      return "Something went wrong. Please check your connection";
    }
  }
}

final AppTools appTools = AppTools();
