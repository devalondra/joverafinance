import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/auth/splash/controller/splash_controller.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';
import 'package:jovera_finance/widgets/background.dart';
import 'package:jovera_finance/widgets/main_text.dart';

final _splashInitProvider = Provider.autoDispose<void>((ref) {
  ref.read(splashControllerProvider.notifier).initialize();
});

class SplashView extends ConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(_splashInitProvider);
    return Background(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/jovera_finance_logo.png',
                  width: fullWidth * 0.7,
                  height: fullWidth * 0.7,
                ),
              ),
            ),

            MainText(
              text: "Version 1.0".tr,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: fullHeight * 0.07),
          ],
        ),
      ),
    );
  }
}
