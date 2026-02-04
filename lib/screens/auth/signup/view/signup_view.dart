import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/screens/auth/signup/controller/signup_controller.dart';
import 'package:jovera_finance/screens/auth/signup/widget/signup_textfields.dart';
import 'package:jovera_finance/utilities/constants/app_tools.dart';
import 'package:jovera_finance/utilities/extensions/widget_extensions.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';
import 'package:jovera_finance/widgets/background.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class SignupView extends ConsumerWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(signUpControllerProvider.notifier);
    ref.watch(signUpControllerProvider);
    final formKey = GlobalKey<FormState>();
    return Background(
      appLoadingController: controller.appLoadingController,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView(
              children: [
                SizedBox(height: fullHeight * 0.01),
                Center(
                  child: Image.asset(
                    'assets/images/jovera_finance_logo.png',
                    width: fullWidth * 0.4,
                    height: fullWidth * 0.4,
                  ),
                ),

                SizedBox(height: fullHeight * 0.04),
                Form(
                  key: formKey,
                  child: SignupTextFields(controller: controller),
                ),
              ],
            ),
          ),
          CustomButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                if (controller.passwordController.text ==
                    controller.retypePasswordController.text) {
                  controller.signup();
                } else {
                  appTools.showErrorSnackBar("Passwords do not match.");
                }
                // Get.to(() => FillProfileView());
              } else {}
            },
            text: "Next".tr,
          ).paddingOnly(bottom: fullHeight * 0.03, top: fullHeight * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MainText(
                text: 'Do you have an account?'.tr,
                textAlign: TextAlign.center,
                fontSize: 15,
                color: AppColors.lightText,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(width: fullWidth * 0.02),
              InkWell(
                onTap: () {
                  final cont = ref.read(
                    bottomNavigationBarControllerProvider.notifier,
                  );
                  cont.isLogin = true;
                },
                child: MainText(
                  text: 'Sign In'.tr,
                  textAlign: TextAlign.center,
                  fontSize: 15,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ).paddingSymmetric(
        horizontal: horizontalPagePadding,
        vertical: verticalPagePadding,
      ),
    );
  }
}
