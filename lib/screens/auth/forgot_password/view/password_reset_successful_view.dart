import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/auth/forgot_password/controller/forgot_password_conttroller.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class PasswordResetSuccessfulView extends GetView<ForgotPasswordController> {
  const PasswordResetSuccessfulView({super.key});

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
            text: "Your password is updated\nsuccessfully".tr,
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
