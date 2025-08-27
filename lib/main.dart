import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jovera_finance/firebase_options.dart';
import 'package:jovera_finance/screens/auth/splash/binding/splash_binding.dart';
import 'package:jovera_finance/screens/auth/splash/view/splash_view.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/services/notification_service.dart';
import 'package:jovera_finance/utilities/services/translation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  SplashBinding().dependencies();
 FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  runApp(
    ScreenUtilInit(
      minTextAdapt: true,
      designSize: ScreenUtil.defaultSize,
      splitScreenMode: true,
      
      builder: (_, __) {
        return MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jovera Finance',
      home: const SplashView(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryLight),
      ),
      translations: TranslationService(),
      locale: TranslationService().getLocale(),
      fallbackLocale: TranslationService.fallbackLocale,
    );
  }
}
