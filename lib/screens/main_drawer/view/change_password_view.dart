import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/constants/app_validators.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';
import 'package:jovera_finance/widgets/custom_text_field.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/custom_button.dart';


class ChangePasswordView extends GetView<BottomNavigationBarController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: fullHeight * 0.02),
                  CustomPageTitle(
                    notification: false,
                    back: true,
                    title: "Change Password".tr,
                  ).paddingSymmetric(horizontal: fullWidth * 0.01),
                  SizedBox(height: fullHeight * 0.07),
                  Obx(
                    () => CustomTextField(
                      controller: controller.currentPasswordController.value,
                      hintText: "Current Password".tr,
                      validator: (value) {
                        return AppValidators().passwordValidation(value);
                      },
                      maxLines: 1,
                      border: true,
                      textColor: AppColors.white,
                      borderColor: AppColors.white,
                      hintStyle: TextStyle(color: AppColors.lightGrey),

                      keyboardType:
                          controller.currentPasswordIsVisible.value
                              ? TextInputType.text
                              : TextInputType.visiblePassword,
                      suffixIcon:
                          controller.currentPasswordIsVisible.value
                              ? GestureDetector(
                                onTap:
                                    () =>
                                        controller
                                            .currentPasswordIsVisible
                                            .value = !controller
                                                .currentPasswordIsVisible
                                                .value,
                                child: Icon(
                                  Icons.visibility,
                                  color: AppColors.grey,
                                ),
                              )
                              : GestureDetector(
                                onTap:
                                    () =>
                                        controller
                                            .currentPasswordIsVisible
                                            .value = !controller
                                                .currentPasswordIsVisible
                                                .value,
                                child: Icon(
                                  Icons.visibility_off,
                                  color: AppColors.grey,
                                ),
                              ),
                    ),
                  ).paddingOnly(bottom: fullHeight * 0.02),

                  Obx(
                    () => CustomTextField(
                      controller: controller.passwordController.value,
                      hintText: "New Password".tr,
                      validator: (value) {
                        return AppValidators().passwordValidation(value);
                      },
                      maxLines: 1,
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
                                child: Icon(
                                  Icons.visibility,
                                  color: AppColors.grey,
                                ),
                              )
                              : GestureDetector(
                                onTap:
                                    () =>
                                        controller.passwordIsVisible.value =
                                            !controller.passwordIsVisible.value,
                                child: Icon(
                                  Icons.visibility_off,
                                  color: AppColors.grey,
                                ),
                              ),
                    ),
                  ).paddingOnly(bottom: fullHeight * 0.02),

                  Obx(
                    () => CustomTextField(
                      controller: controller.confirmPasswordController.value,
                      hintText: "Confirm Password".tr,
                      maxLines: 1,
                      validator: (value) {
                        return AppValidators().passwordValidation(value);
                      },
                      border: true,
                      textColor: AppColors.white,
                      borderColor: AppColors.white,
                      hintStyle: TextStyle(color: AppColors.lightGrey),

                      keyboardType:
                          controller.confirmPasswordIsVisible.value
                              ? TextInputType.text
                              : TextInputType.visiblePassword,
                      suffixIcon:
                          controller.confirmPasswordIsVisible.value
                              ? GestureDetector(
                                onTap:
                                    () =>
                                        controller
                                            .confirmPasswordIsVisible
                                            .value = !controller
                                                .confirmPasswordIsVisible
                                                .value,
                                child: Icon(
                                  Icons.visibility,
                                  color: AppColors.grey,
                                ),
                              )
                              : GestureDetector(
                                onTap:
                                    () =>
                                        controller
                                            .confirmPasswordIsVisible
                                            .value = !controller
                                                .confirmPasswordIsVisible
                                                .value,
                                child: Icon(
                                  Icons.visibility_off,
                                  color: AppColors.grey,
                                ),
                              ),
                    ),
                  ).paddingOnly(bottom: fullHeight * 0.02),

                  SizedBox(height: fullHeight * 0.04),
                ],
              ),
            ),

            CustomButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (controller.confirmPasswordController.value.text ==
                      controller.passwordController.value.text) {
                    controller.changePassword();
                  } else {
                    appTools.showErrorSnackBar("Passwords Do Not Match");
                  }
                }
              },
              text: "Change Password".tr,
            ),
            SizedBox(height: fullHeight * 0.05),
          ],
        ),
      ).paddingSymmetric(
        horizontal: horizontalPagePadding,
        vertical: verticalPagePadding,
      ),
    );
  }
}
