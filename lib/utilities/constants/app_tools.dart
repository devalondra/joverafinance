import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_enums.dart';

class AppTools {
  Future<String>? getFCMTokenForDevice() async {
    // String? fcmToken = await FirebaseMessaging.instance.getToken();
    // debugPrint(fcmToken ?? "");
    return "";// fcmToken??"";
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
        style: Get.textTheme.labelLarge!.copyWith(color: AppColors.white),
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
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
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
    return jsonDecode(error.response.toString()) == null
        ? null
        : jsonDecode(error.response.toString())['message'];
  }
}
