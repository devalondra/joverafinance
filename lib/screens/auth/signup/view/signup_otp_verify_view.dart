import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/auth/signup/controller/signup_controller.dart';
import 'package:pinput/pinput.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class SignupOtpVerifyView extends GetView<SignUpController> {
  const SignupOtpVerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: fullHeight * 0.1),
            Center(
              child: Image.asset(
                'assets/images/jovera_logo.png',
                width: fullWidth * 0.5,
                height: fullWidth * 0.5,
              ),
            ),

            MainText(
              text: 'Verify Code'.tr,

              fontSize: 20,
              fontWeight: FontWeight.w400,
            ).paddingOnly(bottom: fullHeight * 0.01),
            MainText(
              text:
                  'Stay signed in with your account\nto make searching easier'
                      .tr,
              textAlign: TextAlign.center,
              fontSize: 13,
              color: AppColors.lightText,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: fullHeight * 0.08),

            Pinput(
              controller: controller.otpController.value,
              defaultPinTheme: PinTheme(
                width: 56,
                height: 56,
                textStyle: TextStyle(
                  fontSize: 20,
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                ),

                decoration: BoxDecoration(
                  color: AppColors.black2,
                  borderRadius: BorderRadius.circular(fullWidth * 0.02),
                ),
              ),
            ),
            SizedBox(height: fullHeight * 0.08),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     MainText(
            //       text: 'Didn\'t get the Code?'.tr,
            //       textAlign: TextAlign.center,
            //       fontSize: 14,
            //       color: AppColors.lightText,
            //       fontWeight: FontWeight.w400,
            //     ),
            //     SizedBox(width: fullWidth * 0.01),
            //     InkWell(
            //       onTap: () {
            //         controller.otpController.value.clear();
            //         controller.resendOtp();
            //       },
            //       child: MainText(
            //         text: 'Resend'.tr,
            //         textAlign: TextAlign.center,
            //         fontSize: 14,
            //         color: AppColors.primary,
            //         fontWeight: FontWeight.w400,
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: fullHeight * 0.1),
            CustomButton(
              onPressed: () {
                //       controller.verifyOtp();
              },
              text: "Verify".tr,
            ),
          ],
        ).paddingSymmetric(
          horizontal: horizontalPagePadding,
          vertical: verticalPagePadding,
        ),
      ),
    );
  }
}
