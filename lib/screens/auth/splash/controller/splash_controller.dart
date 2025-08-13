import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jovera_finance/screens/auth/language/binding/language_binding.dart';
import 'package:jovera_finance/screens/auth/language/view/language_view.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/binding/bottom_navigation_bar_binding.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/view/bottom_navigation_bar_view.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/services/notification_service.dart';

class SplashController extends GetxController {
  final AuthManager authManager = Get.put(AuthManager());

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GetStorage storage = GetStorage();
  bool? firstTime;

  @override
  Future<void> onInit() async {
    firstTime = await getFirstTime();
    super.onInit();
  }

  Future<bool> getFirstTime() async {
    return storage.read('first_time') ?? false;
  }

  @override
  Future<void> onReady() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await authManager.checkLoginStatus();
      correctPage();
    });
    super.onReady();
  }

  Future correctPage() async {
    if (!firstTime!) {
      Get.off(() => const LanguageView(), binding: LanguageBinding());
    } else {
      Get.lazyPut(() => NotificationService());
      await Get.putAsync(() => NotificationService().init());
      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
      BottomNavigationBarBinding().dependencies();
      Get.offAll(
        () => const BottomnavigationBarView(),
        binding: BottomNavigationBarBinding(),
      );
    }
  }
}
