import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_validators.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/screens/auth/forgot_password/controller/forgot_password_conttroller.dart';
import 'package:jovera_finance/utilities/extensions/widget_extensions.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';
import 'package:jovera_finance/widgets/background.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';
import 'package:jovera_finance/widgets/custom_text_field.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class ForgotPasswordView extends ConsumerWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(forgotPasswordControllerProvider.notifier);
    ref.watch(forgotPasswordControllerProvider);
    final formKey = GlobalKey<FormState>();
    return Background(
      appLoadingController: controller.appLoadingController,
      // safeAreaBottom: true,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CustomPageTitle(
                back: true,
                notification: false,
                title: 'Forgot Password?',
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
                    'Enter your Email, we will send you a\nverification code.',
                textAlign: TextAlign.center,
                fontSize: 13,
                color: AppColors.lightText,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: fullHeight * 0.06),
              Form(
                key: formKey,
                child: CustomTextField(
                  controller: controller.emailController,
                  hintText: "Email".tr,
                  validator: (value) {
                    return AppValidators().email(value);
                  },
                  border: true,
                  textColor: AppColors.white,
                  borderColor: AppColors.white,
                  hintStyle: TextStyle(color: AppColors.lightGrey),
                ).paddingOnly(bottom: fullHeight * 0.02),
              ),

              SizedBox(height: fullHeight * 0.1),
              CustomButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    controller.forgotPassword();
                  }
                },
                text: "Send code".tr,
              ).paddingOnly(bottom: fullHeight * 0.05),
            ],
          ).paddingSymmetric(
            horizontal: horizontalPagePadding,
            vertical: verticalPagePadding,
          ),
        ),
      ),
    );
  }
}
