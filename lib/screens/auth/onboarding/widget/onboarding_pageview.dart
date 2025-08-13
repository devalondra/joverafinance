import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/screens/auth/onboarding/controller/onboarding_controller.dart';
import 'package:jovera_finance/widgets/main_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingPageView extends GetView<OnBoardingController> {
  const OnBoardingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller.pageController,
      onPageChanged: (value) {
        controller.onPageChanged(value);
      },
      itemCount: onBoardingList.length,
      itemBuilder:
          (context, index) => Center(
            child: Column(
              children: [
                SizedBox(height: fullHeight * 0.15),
                SvgPicture.asset(
                  onBoardingList[index].imageUrl!,
                  height: fullWidth * 0.7,
                  width: fullWidth * 0.7,
                  fit: BoxFit.cover,
                ),

                // Container(decoration: BoxDecoration(color: AppColors.primary)),
                SizedBox(height: fullHeight * 0.01),

                MainText(
                  text: onBoardingList[index].title!.tr,
                  fontSize: 24,
                  height: 1.3,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w400,
                ).paddingOnly(
                  top: Get.width * 0.05,
                  bottom: Get.width * 0.02,
                  left: horizontalPagePadding * 1.5,
                  right: horizontalPagePadding * 1.5,
                ),

                MainText(
                  text: onBoardingList[index].body!.tr,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,

                  height: 1.5,
                  color: AppColors.grey,
                  textAlign: TextAlign.center,
                ).paddingAll(Get.width * 0.04),
              ],
            ),
          ),
    );
  }
}
