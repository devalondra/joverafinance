import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/constants/app_validators.dart';
import 'package:jovera_finance/widgets/custom_text_field.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/screens/auth/forgot_password/controller/forgot_password_conttroller.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class CreateNewPasswordView extends GetView<ForgotPasswordController> {
  const CreateNewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                text: 'Create New Password',

                fontSize: 20,
                fontWeight: FontWeight.w400,
              ).paddingOnly(bottom: fullHeight * 0.01),
              MainText(
                text:
                    'Your new password must be different\nform previously used password'
                        .tr,
                textAlign: TextAlign.center,
                fontSize: 13,
                color: AppColors.lightText,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: fullHeight * 0.1),

              Obx(
                () => CustomTextField(
                  controller: controller.passwordController.value,
                  hintText: "Password".tr,
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
                                    controller.confirmPasswordIsVisible.value =
                                        !controller
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
                                    controller.confirmPasswordIsVisible.value =
                                        !controller
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
              CustomButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (controller.confirmPasswordController.value.text ==
                        controller.passwordController.value.text) {
                      controller.createNewPassword();
                    } else {
                      appTools.showErrorSnackBar("Passwords Do Not Match");
                    }
                  }
                },
                text: "Reset Password".tr,
              ),
            ],
          ),
        ).paddingSymmetric(
          horizontal: horizontalPagePadding,
          vertical: verticalPagePadding,
        ),
      ),
    );
  }
}
