import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/screens/auth/language/controller/language_controller.dart';
import 'package:jovera_finance/widgets/background.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class LanguageView extends GetView<LanguageController> {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        key: controller.scaffoldKey,
        backgroundColor: AppColors.backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: fullHeight * 0.15),
                    Image.asset(
                      'assets/images/jovera_finance_logo.png',
                      width: fullWidth * 0.7,
                      height: fullWidth * 0.7,
                    ),
                    SizedBox(height: fullHeight * 0.05),
                    CustomButton(
                      text: 'English',

                      onPressed: () {
                        controller.changeLanguage("en_US");
                      },
                    ).paddingOnly(bottom: fullHeight * 0.02),
                    CustomButton(
                      text: 'العربية',
                      color: AppColors.transparent,
                      borderColor: AppColors.grey,
                      onPressed: () {
                        controller.changeLanguage("ar_SA");
                      },
                    ),
                  ],
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
        ).paddingSymmetric(
          horizontal: horizontalPagePadding,
          vertical: verticalPagePadding,
        ),
      ),
    );
  }
}
