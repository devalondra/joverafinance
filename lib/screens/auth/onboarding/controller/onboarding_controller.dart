import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jovera_finance/screens/auth/onboarding/model/on_boarding_model.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/binding/bottom_navigation_bar_binding.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/view/bottom_navigation_bar_view.dart';
import 'package:jovera_finance/utilities/services/notification_service.dart';

class OnBoardingController extends GetxController {
  late PageController pageController;
  RxInt currentPage = 0.obs;
  final GetStorage storage = GetStorage();
  saveFirstTime() async {
    await storage.write("first_time", true);
  }

  Future<void> next() async {
    if (currentPage.value > onBoardingList.length - 2) {
      skip();
    } else {
      currentPage.value++;
      await pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> skip() async {
    await Get.putAsync(() => NotificationService().init());
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    await saveFirstTime();
    Get.offAll(
      () => BottomnavigationBarView(),
      binding: BottomNavigationBarBinding(),
    );
  }

  void onPageChanged(int index) {
    currentPage.value = index;
    update();
  }

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
    'Apply for a loan',
    "assets/images/onboarding1.svg",
    'Follow our quick steps process within\nthe app to apply for a loan',
  ),
  OnBoardingModel(
    'Your loan is disbursed',
    "assets/images/onboarding2.svg",
    'Once your request is approved,  your\nloan is disbursed',
  ),
  OnBoardingModel(
    'Cash easily',
    "assets/images/onboarding3.svg",
    'Once your loan is approved you can\ncash at the nearest ATM',
  ),
];
