import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jovera_finance/utilities/lang/ar.dart';
import 'package:jovera_finance/utilities/lang/en.dart';

class TranslationService extends Translations {
  static GetStorage localStorage = GetStorage();

  @override
  Map<String, Map<String, String>> get keys => {'en_US': en, 'ar_SA': ar};
  static const fallbackLocale = Locale('en', 'US');

  void changeLocale(String lang) async {
    if (lang == 'en_US') {
      Get.updateLocale(Locale('en', 'US'));
      await localStorage.write('language', 'en_US');
    } else if (lang == 'ar_SA') {
      Get.updateLocale(Locale('ar', 'SA'));
      await localStorage.write('language', 'ar_SA');
    }
  }

  Locale getLocale() {
    String? currentLocale = localStorage.read('language');
    if (currentLocale == 'en_US') {
      return Locale('en', 'US');
    } else if (currentLocale == 'ar_SA') {
      return Locale('ar', 'SA');
    }
    return fallbackLocale;
  }
}
