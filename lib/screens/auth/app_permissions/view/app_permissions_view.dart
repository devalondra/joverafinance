import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/auth/app_permissions/controller/app_permissions_controller.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/main_text.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPermissionsView extends GetView<AppPermissionsController> {
  const AppPermissionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: ListView(
          children: [
            SizedBox(height: 0.03.sh),

            MainText(
              textAlign: TextAlign.center,

              text:
                  'User Consent Statement'.tr,

              fontSize: 18.sp,
            ),
            SizedBox(height: 0.05.sh),
            MainText(
              textAlign: TextAlign.justify,
              text:
                  'By using the Jovera Tourism app, you acknowledge and agree that:'
                      .tr,
              color: AppColors.primary,
              fontSize: 14.sp,
            ),
            SizedBox(height: fullHeight * 0.03),
            MainText(
              textAlign: TextAlign.justify,

              text:
                  'Jovera Tourism L.L.C – O.P.C is a private travel service provider that facilitates the UAE tourist visa application process. Our app guides you through:'
                      .tr,
              fontSize: 13.sp,
            ),
            SizedBox(height: fullHeight * 0.03),
            Row(
              children: [
                MainText(
                  textAlign: TextAlign.start,

                  text: '• '.tr,
                  fontSize: 13.sp,
                ),
                MainText(
                  textAlign: TextAlign.start,

                  text: 'Submitting documents'.tr,
                  fontSize: 13.sp,
                ),
              ],
            ),

            Row(
              children: [
                MainText(
                  textAlign: TextAlign.start,

                  text: '• '.tr,
                  fontSize: 13.sp,
                ),
                MainText(
                  textAlign: TextAlign.start,

                  text: 'Completing secure payments'.tr,
                  fontSize: 13.sp,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainText(
                  textAlign: TextAlign.start,

                  text: '• '.tr,
                  fontSize: 13.sp,
                ),
                Expanded(
                  child: MainText(
                    textAlign: TextAlign.start,

                    text:
                        'Tracking and receiving updates about your application status'
                            .tr,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: fullHeight * 0.03),
            MainText(
              textAlign: TextAlign.justify,

              text:
                  'We are not a government authority or immigration department, and final visa decisions rest solely with UAE immigration.'
                      .tr,
              fontSize: 12.sp,
            ),
            SizedBox(height: fullHeight * 0.03),
            MainText(
              textAlign: TextAlign.justify,

              text:
                  'By proceeding, you consent to the collection and processing of your information for the purpose of providing visa assistance and related travel services in accordance with our Privacy Policy and'
                      .tr,
              fontSize: 13.sp,
            ),

            InkWell(
              onTap: () async {
                await launchUrl(
                  Uri.parse(
                    "https://joveratourism.ae/components/termsConditions",
                  ),
                ).onError((error, stackTrace) {
                  appTools.showErrorSnackBar(
                    'Something went wrong. Please check your connection.',
                  );
                  throw Exception();
                });
              },
              child: MainText(
                textAlign: TextAlign.justify,
                color: AppColors.primary,
                decoration: TextDecoration.underline,
                text: "Terms & Conditions.".tr,
                fontSize: 13.sp,
              ),
            ),

            SizedBox(height: fullHeight * 0.03),
            MainText(
              textAlign: TextAlign.center,
              color: AppColors.lightText,

              text: 'If you wish not to proceed, you may exit anytime.'.tr,
              fontSize: 12.sp,
            ),
            SizedBox(height: fullHeight * 0.02),
            CustomButton(
              onPressed: () async {
                await launchUrl(
                  Uri.parse(
                    "https://joveratourism.ae/components/privacyPolicy",
                  ),
                ).onError((error, stackTrace) {
                  appTools.showErrorSnackBar(
                    'Something went wrong. Please check your connection.',
                  );
                  throw Exception();
                });
              },

              text: "Read our Privacy Policy".tr,
            ),
            SizedBox(height: fullHeight * 0.01),
            CustomButton(
              text: "Agree and Continue".tr,
              color: AppColors.black2,
              borderColor: AppColors.white,
              onPressed: () {
                controller.goToLogin();
              },
            ),
            SizedBox(height: fullHeight * 0.01),
          ],
        ).paddingSymmetric(
          vertical: verticalPagePadding,
          horizontal: horizontalPagePadding,
        ),
      ),
    );
  }
}
