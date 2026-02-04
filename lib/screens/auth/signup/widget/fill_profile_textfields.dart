import 'package:flutter/material.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_validators.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/screens/auth/signup/controller/signup_controller.dart';
import 'package:jovera_finance/utilities/extensions/widget_extensions.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';
import 'package:jovera_finance/widgets/custom_text_field.dart';

class FillProfileTextFields extends StatelessWidget {
  const FillProfileTextFields({super.key, required this.controller});
  final SignUpController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: controller.passwordController,
          hintText: "Password".tr,
          textInputAction: TextInputAction.next,
          onSubmitted: (_) => FocusScope.of(context).nextFocus(),
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
        ).paddingOnly(bottom: fullHeight * 0.025),
        CustomTextField(
          controller: controller.retypePasswordController,
          hintText: "Re-type Password".tr,
          maxLines: 1,
          textInputAction: TextInputAction.done, // Moves focus to next.
          onSubmitted: (_) => FocusScope.of(context).unfocus(),
          validator: (value) {
            return AppValidators().passwordValidation(value);
          },
          border: true,
          textColor: AppColors.white,
          borderColor: AppColors.white,
          hintStyle: TextStyle(color: AppColors.lightGrey),

          keyboardType:
              controller.retypePasswordIsVisible
                  ? TextInputType.text
                  : TextInputType.visiblePassword,
          suffixIcon:
              controller.retypePasswordIsVisible
                  ? GestureDetector(
                    onTap: () {
                      controller.retypePasswordIsVisible =
                          !controller.retypePasswordIsVisible;
                    },
                    child: Icon(Icons.visibility, color: AppColors.grey),
                  )
                  : GestureDetector(
                    onTap: () {
                      controller.retypePasswordIsVisible =
                          !controller.retypePasswordIsVisible;
                    },
                    child: Icon(Icons.visibility_off, color: AppColors.grey),
                  ),
        ).paddingOnly(bottom: fullHeight * 0.025),
      ],
    );
  }
}
