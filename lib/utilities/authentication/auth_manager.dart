import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jovera_finance/screens/auth/login/model/users.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/binding/bottom_navigation_bar_binding.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/view/bottom_navigation_bar_view.dart';
import 'package:jovera_finance/screens/main_drawer/notification/controller/notification_controller.dart';
import 'package:jovera_finance/utilities/api/api_service.dart';
import 'package:jovera_finance/utilities/authentication/cache_manager.dart';
import 'package:jovera_finance/utilities/constants/app_tools.dart';
import 'package:jovera_finance/utilities/services/notification_service.dart';

final AppTools appTools = AppTools();
final TextTheme textTheme = TextTheme();

class AuthManager extends GetxController with CacheManager {
  final GetStorage storage = GetStorage();

  final isLogged = false.obs;

  Rx<AppUser> appUser = AppUser().obs;

  Future<void> logOut() async {
    if (isLogged.value) {
      //  api.logout();
      isLogged.value = false;
    }
    await storage.erase();
    await storage.write('first_time', true);

    Get.offAll(
      () => BottomnavigationBarView(),
      binding: BottomNavigationBarBinding(),
    );
    Future.delayed(const Duration(seconds: 1), () {
      appUser.value = AppUser();
    });
    appTools.showSuccessSnackBar('loggedOutSuccess', timer: 1);
  }

  void login() async {
    isLogged.value = true;
    await saveToken(appUser.value.token);
    final NotificationService notificationService = Get.find();
    //todo
    notificationService.initSocketConnection();
    if (!Get.isRegistered<NotificationController>()) {
      Get.put(NotificationController());
      Get.put(ApiService());
    }
  }

  Future<void> checkLoginStatus() async {
    final token = getToken();
    if (token != null) {
      isLogged.value = true;
      final ApiService apiService = Get.put(ApiService());
      await apiService.getUserDataByToken(token);

      if (!Get.isRegistered<NotificationController>()) {
        Get.put(NotificationController());
      }
    }
  }
}
