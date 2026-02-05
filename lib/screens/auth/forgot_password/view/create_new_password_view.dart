import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/utilities/constants/app_validators.dart';
import 'package:jovera_finance/widgets/custom_text_field.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/screens/auth/forgot_password/controller/forgot_password_conttroller.dart';
import 'package:jovera_finance/utilities/constants/app_tools.dart';
import 'package:jovera_finance/utilities/extensions/widget_extensions.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class CreateNewPasswordView extends ConsumerWidget {
  const CreateNewPasswordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(forgotPasswordControllerProvider.notifier);
    ref.watch(forgotPasswordControllerProvider);
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomPageTitle(
                back: true,
                notification: false,
                title: 'Create New Password',
              ),
              SizedBox(height: fullHeight * 0.02),
              Center(
                child: Image.asset(
                  'assets/images/jovera_logo.png',
                  width: fullWidth * 0.5,
                  height: fullWidth * 0.5,
                ),
              ),
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

              CustomTextField(
                controller: controller.passwordController,
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
                          child: Icon(Icons.visibility, color: AppColors.grey),
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
              CustomButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (controller.confirmPasswordController.text ==
                        controller.passwordController.text) {
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
