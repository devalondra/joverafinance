import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/screens/auth/onboarding/controller/onboarding_controller.dart';
import 'package:jovera_finance/screens/auth/onboarding/widget/dots.controller.dart';
import 'package:jovera_finance/screens/auth/onboarding/widget/onboarding_pageview.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class OnboardingView extends GetView<OnBoardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          OnBoardingPageView(),
          Center(
            child:
            // Obx(
            //   () =>
            Column(
              children: [
                SizedBox(height: Get.height * 0.74),

                CustomButton(
                  color: AppColors.primary,
                  width: double.infinity,
                  borderRadius: fullWidth * 0.02,
                  textColor: AppColors.white,
                  text: 'Next'.tr,
                  onPressed: () async {
                    await controller.next();
                  },
                ).paddingAll(fullWidth * 0.06),
                SizedBox(height: fullHeight * 0.01),
                DotsController(),
                SizedBox(height: fullHeight * 0.01),
                InkWell(
                  onTap: () async {
                    await controller.skip();
                  },
                  child: MainText(
                    text: 'Skip'.tr,
                    color: AppColors.primaryLight,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            //  ),
          ),
        ],
      ),
    );
  }
}
