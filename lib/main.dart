import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jovera_finance/firebase_options.dart';
import 'package:jovera_finance/screens/auth/splash/view/splash_view.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/localization/app_localizations.dart';
import 'package:jovera_finance/utilities/localization/locale_controller.dart';
import 'package:jovera_finance/utilities/navigation/app_messenger.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';
import 'package:jovera_finance/utilities/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  runApp(
    ProviderScope(
      child: ScreenUtilInit(
        minTextAdapt: true,
        designSize: ScreenUtil.defaultSize,
        splitScreenMode: true,
        builder: (_, __) {
          return const MyApp();
        },
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeControllerProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jovera Finance',
      home: const SplashView(),
      navigatorKey: AppNavigator.key,
      scaffoldMessengerKey: AppMessenger.key,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryLight),
      ),
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
