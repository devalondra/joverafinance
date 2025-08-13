import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jovera_finance/screens/auth/onboarding/binding/onboarding_binding.dart';
import 'package:jovera_finance/screens/auth/onboarding/view/onboarding_view.dart';
import 'package:jovera_finance/utilities/services/notification_service.dart';

class AppPermissionsController extends GetxController {
  RxBool showPermissionButton = false.obs;
  GetStorage storage = GetStorage();
  goToLogin() async {
    await Get.putAsync(() => NotificationService().init());
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    Get.off(
      () => const OnboardingView(),
      binding: OnboardingBinding(),
      popGesture: false,
      curve: Curves.easeInOut,
      transition: Transition.rightToLeft,
    );
  }
}
