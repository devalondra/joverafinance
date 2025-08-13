import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/auth/signup/controller/signup_controller.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class SignupSuccessfulView extends GetView<SignUpController> {
  const SignupSuccessfulView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/icons/done_icon.svg"),
          SizedBox(height: fullHeight * 0.05),
          MainText(
            text: "Congratulations".tr,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
          SizedBox(height: fullHeight * 0.01),
          MainText(
            text:
                "A verification email has been sent to your address. Please verify and continue."
                    .tr,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: fullHeight * 0.1),
          CustomButton(
            onPressed: () {
              controller.secretLogin();
            },
            text: "Next".tr,
          ),
        ],
      ).paddingSymmetric(
        horizontal: horizontalPagePadding,
        vertical: verticalPagePadding,
      ),
    );
  }
}
