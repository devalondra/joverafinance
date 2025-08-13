import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_validators.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/screens/auth/signup/controller/signup_controller.dart';
import 'package:jovera_finance/widgets/custom_text_field.dart';

class FillProfileTextFields extends StatelessWidget {
  const FillProfileTextFields({super.key, required this.controller});
  final SignUpController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => CustomTextField(
            controller: controller.passwordController.value,
            hintText: "Password".tr,
            textInputAction: TextInputAction.next, // Moves focus to next.
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
                controller.passwordIsVisible.value
                    ? TextInputType.text
                    : TextInputType.visiblePassword,
            suffixIcon:
                controller.passwordIsVisible.value
                    ? GestureDetector(
                      onTap:
                          () =>
                              controller.passwordIsVisible.value =
                                  !controller.passwordIsVisible.value,
                      child: Icon(Icons.visibility, color: AppColors.grey),
                    )
                    : GestureDetector(
                      onTap:
                          () =>
                              controller.passwordIsVisible.value =
                                  !controller.passwordIsVisible.value,
                      child: Icon(Icons.visibility_off, color: AppColors.grey),
                    ),
          ),
        ).paddingOnly(bottom: fullHeight * 0.025),
        Obx(
          () => CustomTextField(
            controller: controller.retypePasswordController.value,
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
                controller.retypePasswordIsVisible.value
                    ? TextInputType.text
                    : TextInputType.visiblePassword,
            suffixIcon:
                controller.retypePasswordIsVisible.value
                    ? GestureDetector(
                      onTap:
                          () =>
                              controller.retypePasswordIsVisible.value =
                                  !controller.retypePasswordIsVisible.value,
                      child: Icon(Icons.visibility, color: AppColors.grey),
                    )
                    : GestureDetector(
                      onTap:
                          () =>
                              controller.retypePasswordIsVisible.value =
                                  !controller.retypePasswordIsVisible.value,
                      child: Icon(Icons.visibility_off, color: AppColors.grey),
                    ),
          ),
        ).paddingOnly(bottom: fullHeight * 0.025),

        Obx(
          () => InkWell(
            onTap: () {
              controller.showCupertinoDialog();
            },
            child: CustomTextField(
              controller: controller.dateOfBirthController.value,
              hintText: "Date of birth".tr,
              disable: true,
              validator: (value) {
                return AppValidators().textValidation(value);
              },
              prefixIcon: SizedBox(
                width: fullWidth * 0.15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/calender_icon.svg",
                      width: fullWidth * 0.052,
                      height: fullWidth * 0.052,
                    ),
                    SizedBox(width: fullWidth * 0.023),
                    Container(
                      height: fullHeight * 0.025,
                      width: fullWidth * 0.005,
                      color: AppColors.lightGrey,
                    ),
                  ],
                ),
              ),
              border: true,
              textColor: AppColors.white,
              borderColor: AppColors.white,
              hintStyle: TextStyle(color: AppColors.lightGrey),
            ).paddingOnly(bottom: fullHeight * 0.025),
          ),
        ),
      ],
    );
  }
}
