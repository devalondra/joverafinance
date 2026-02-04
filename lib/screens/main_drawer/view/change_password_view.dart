import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/utilities/constants/app_validators.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';
import 'package:jovera_finance/widgets/custom_text_field.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/utilities/constants/app_tools.dart';
import 'package:jovera_finance/utilities/extensions/widget_extensions.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';


class ChangePasswordView extends ConsumerWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(bottomNavigationBarControllerProvider.notifier);
    ref.watch(bottomNavigationBarControllerProvider);
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Form(
        key: formKey,
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
                  CustomTextField(
                    controller: controller.currentPasswordController,
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
                        controller.currentPasswordIsVisible
                            ? TextInputType.text
                            : TextInputType.visiblePassword,
                    suffixIcon:
                        controller.currentPasswordIsVisible
                            ? GestureDetector(
                              onTap: () {
                                controller.currentPasswordIsVisible =
                                    !controller.currentPasswordIsVisible;
                              },
                              child: Icon(
                                Icons.visibility,
                                color: AppColors.grey,
                              ),
                            )
                            : GestureDetector(
                              onTap: () {
                                controller.currentPasswordIsVisible =
                                    !controller.currentPasswordIsVisible;
                              },
                              child: Icon(
                                Icons.visibility_off,
                                color: AppColors.grey,
                              ),
                            ),
                  ).paddingOnly(bottom: fullHeight * 0.02),

                  CustomTextField(
                    controller: controller.passwordController,
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
                              child: Icon(
                                Icons.visibility,
                                color: AppColors.grey,
                              ),
                            )
                            : GestureDetector(
                              onTap: () {
                                controller.passwordIsVisible =
                                    !controller.passwordIsVisible;
                              },
                              child: Icon(
                                Icons.visibility_off,
                                color: AppColors.grey,
                              ),
                            ),
                  ).paddingOnly(bottom: fullHeight * 0.02),

                  CustomTextField(
                    controller: controller.confirmPasswordController,
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
                        controller.confirmPasswordIsVisible
                            ? TextInputType.text
                            : TextInputType.visiblePassword,
                    suffixIcon:
                        controller.confirmPasswordIsVisible
                            ? GestureDetector(
                              onTap: () {
                                controller.confirmPasswordIsVisible =
                                    !controller.confirmPasswordIsVisible;
                              },
                              child: Icon(
                                Icons.visibility,
                                color: AppColors.grey,
                              ),
                            )
                            : GestureDetector(
                              onTap: () {
                                controller.confirmPasswordIsVisible =
                                    !controller.confirmPasswordIsVisible;
                              },
                              child: Icon(
                                Icons.visibility_off,
                                color: AppColors.grey,
                              ),
                            ),
                  ).paddingOnly(bottom: fullHeight * 0.02),

                  SizedBox(height: fullHeight * 0.04),
                ],
              ),
            ),

            CustomButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (controller.confirmPasswordController.text ==
                      controller.passwordController.text) {
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
