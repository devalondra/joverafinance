import 'package:flutter/material.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_validators.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/screens/auth/login/controller/login_controller.dart';
import 'package:jovera_finance/utilities/extensions/widget_extensions.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';
import 'package:jovera_finance/widgets/custom_text_field.dart';

class LoginTextFields extends StatelessWidget {
  const LoginTextFields({super.key, required this.controller});
  final LoginController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: controller.emailController,
          hintText: "Email/Phone".tr,
          validator: (value) {
            return AppValidators().textValidation(value);
          },
          border: true,
          textColor: AppColors.white,
          borderColor: AppColors.white,
          hintStyle: TextStyle(color: AppColors.lightGrey),
        ).paddingOnly(bottom: fullHeight * 0.02),

        CustomTextField(
          controller: controller.passwordController,
          hintText: "Password".tr,
          maxLines: 1,
          validator: (value) {
            return AppValidators().passwordValidation(value);
          },
          border: true,
          textColor: AppColors.white,
          borderColor: AppColors.white,
          hintStyle: TextStyle(color: AppColors.lightGrey),

          keyboardType:
              controller.passwordIsVisible
                  ? TextInputType.text
                  : TextInputType.visiblePassword,
          suffixIcon:
              controller.passwordIsVisible
                  ? GestureDetector(
                    onTap: () {
                      controller.passwordIsVisible =
                          !controller.passwordIsVisible;
                    },
                    child: Icon(Icons.visibility, color: AppColors.grey),
                  )
                  : GestureDetector(
                    onTap: () {
                      controller.passwordIsVisible =
                          !controller.passwordIsVisible;
                    },
                    child: Icon(Icons.visibility_off, color: AppColors.grey),
                  ),
        ).paddingOnly(bottom: fullHeight * 0.01),
      ],
    );
  }
}
