import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/auth/app_permissions/controller/app_permissions_controller.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_tools.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/utilities/extensions/widget_extensions.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/main_text.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPermissionsView extends ConsumerWidget {
  const AppPermissionsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(appPermissionsControllerProvider.notifier);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: ListView(
          children: [
            SizedBox(height: 0.03.sh),

            MainText(
              textAlign: TextAlign.center,

              text: 'User Consent Statement'.tr,

              fontSize: 18.sp,
            ),
            SizedBox(height: 0.05.sh),
            MainText(
              textAlign: TextAlign.justify,
              text:
                  'By using the Jovera Finance app, you acknowledge and agree that:'
                      .tr,
              color: AppColors.primary,
              fontSize: 14.sp,
            ),
            SizedBox(height: fullHeight * 0.03),
            MainText(
              textAlign: TextAlign.justify,

              text:
                  'Jovera Finance is a financial consultancy and loan facilitation service which provides,'
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

                  text: 'Mortgage loan solutions.'.tr,
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

                  text: 'Business loan advisory and facilitation.'.tr,
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

                    text: 'Personal loan advisory and facilitation.'.tr,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: fullHeight * 0.03),
            MainText(
              textAlign: TextAlign.justify,

              text:
                  'We act as a financial solutions provider and facilitator, not as a bank or direct lender. Actual loan approval, terms, and conditions are subject to the policies of banks and financial institutions we work with.'
                      .tr,
              fontSize: 12.sp,
            ),
            SizedBox(height: fullHeight * 0.03),
            MainText(
              textAlign: TextAlign.justify,

              text:
                  'By proceeding, you consent to the collection and processing of your information for the purpose of providing assistance and consultation related to financial solutions in accordance with our Privacy Policy and'
                      .tr,
              fontSize: 13.sp,
            ),

            InkWell(
              onTap: () async {
                await launchUrl(
                  Uri.parse("https://www.jovera.ae/terms-of-service/"),
                ).onError((error, stackTrace) {
                  appTools.showErrorSnackBar(
                    'Something went wrong. Please check your connection.'.tr,
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
                  Uri.parse("https://www.jovera.ae/privacy-policy/"),
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
