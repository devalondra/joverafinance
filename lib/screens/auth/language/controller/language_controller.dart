import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/auth/app_permissions/binding/app_permissions_binding.dart';
import 'package:jovera_finance/screens/auth/app_permissions/view/app_permissions_view.dart';
import 'package:jovera_finance/utilities/services/translation_service.dart';

class LanguageController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool? firstTime;
  RxString selectedLanguage = TranslationService().getLocale().toString().obs;

  void changeLanguage(String languageCode) {
    TranslationService().changeLocale(languageCode);
    selectedLanguage.value = languageCode;

    Get.to(() => const AppPermissionsView(), binding: AppPermissionsBinding());
    // Get.offAll(() => OnboardingView(), binding: OnboardingBinding());
  }

  @override
  Future<void> onInit() async {
    super.onInit();
  }
}
