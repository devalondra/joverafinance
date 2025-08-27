import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/screens/auth/forgot_password/binding/forgot_password_binding.dart';
import 'package:jovera_finance/screens/auth/forgot_password/view/forgot_password_view.dart';
import 'package:jovera_finance/screens/auth/login/controller/login_controller.dart';
import 'package:jovera_finance/screens/auth/login/widget/login_textfields.dart';
import 'package:jovera_finance/widgets/background.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Background(
      appLoadingController: controller.appLoadingController,
      // safeAreaBottom: true,
      child: Scaffold(
        key: controller.scaffoldKey,
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Image.asset(
                  'assets/images/jovera_logo.png',
                  width: fullWidth * 0.5,
                  height: fullWidth * 0.5,
                ),
              ),

              SizedBox(height: fullHeight * 0.04),
              Form(
                key: formKey,
                child: LoginTextFields(controller: controller),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          value: controller.keepSignIn.value,
                          onChanged: (value) {
                            controller.keepSignIn.value = value!;
                          },

                          side: BorderSide(color: AppColors.white, width: 2),
                          checkColor: AppColors.white,

                          activeColor: AppColors.backgroundColor,
                          overlayColor: WidgetStateProperty.resolveWith<Color>((
                            states,
                          ) {
                            if (states.contains(WidgetState.selected)) {
                              return AppColors.white;
                            }
                            return AppColors.white;
                          }),
                          fillColor: WidgetStateProperty.resolveWith<Color>((
                            states,
                          ) {
                            if (states.contains(WidgetState.selected)) {
                              return AppColors.primary;
                            }
                            return AppColors.transparent;
                          }),
                        ),
                      ),
                      MainText(text: "Keep me signed in".tr, fontSize: 14),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        () => ForgotPasswordView(),
                        binding: ForgotpasswordBinding(),
                      );
                    },
                    child: MainText(
                      text: "Forgot password?".tr,
                      color: AppColors.primary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: fullHeight * 0.03),
              CustomButton(
                onPressed: () {
                  // controller.emailController.value.text =
                  //     "kashufhameed@gmail.com";
                  // controller.passwordController.value.text = "123123";
                  if (formKey.currentState!.validate()) {
                    controller.login();
                  }
                },
                text: "Log In".tr,
              ).paddingOnly(bottom: fullHeight * 0.025),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       height: fullHeight * 0.002,
              //       width: fullWidth * 0.24,
              //       decoration: BoxDecoration(
              //         gradient: LinearGradient(
              //           colors: [AppColors.backgroundColor, AppColors.grey],
              //         ),
              //       ),
              //     ).paddingSymmetric(horizontal: fullWidth * 0.01),
              //     MainText(
              //       text: "Or continue with".tr,
              //       fontSize: 14.spMin,
              //       color: AppColors.grey,
              //     ),
              //     Container(
              //       height: fullHeight * 0.002,
              //       width: fullWidth * 0.24,
              //       decoration: BoxDecoration(
              //         gradient: LinearGradient(
              //           colors: [AppColors.grey, AppColors.backgroundColor],
              //         ),
              //       ),
              //     ).paddingSymmetric(horizontal: fullWidth * 0.01),
              //   ],
              // ),
              SizedBox(height: fullHeight * 0.004),
              MainText(
                text: "OR".tr,
                fontSize: 14.spMin,
                color: AppColors.grey,
              ),
              SizedBox(height: fullHeight * 0.02),
              InkWell(
                onTap: () {
                  controller.handleGoogleSignIn();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: fullHeight * 0.007),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(fullWidth * 0.02),

                    color: AppColors.black2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/google_icon.svg",
                        width: fullHeight * 0.028,
                        height: fullHeight * 0.028,
                      ),
                      SizedBox(width: fullWidth * 0.04),
                      MainText(
                        text: "Sign in with Google".tr,
                        fontSize: 14.spMin,
                        color: AppColors.grey,
                      ),

                      // InkWell(
                      //   onTap: () {
                      //     controller.handleGoogleSignIn();
                      //   },
                      //   child: Stack(
                      //     alignment: Alignment.center,
                      //     children: [
                      //       SvgPicture.asset("assets/icons/login_gradient.svg"),
                      //       Center(
                      //         child: SvgPicture.asset(
                      //           "assets/icons/google_icon.svg",
                      //           width: fullHeight * 0.028,
                      //           height: fullHeight * 0.028,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Stack(
                      //   alignment: Alignment.center,
                      //   children: [
                      //     SvgPicture.asset("assets/icons/login_gradient.svg"),
                      //     Center(
                      //       child: SvgPicture.asset(
                      //         "assets/icons/apple_icon.svg",
                      //         width: fullHeight * 0.028,
                      //         height: fullHeight * 0.028,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Stack(
                      //   alignment: Alignment.center,
                      //   children: [
                      //     SvgPicture.asset("assets/icons/login_gradient.svg"),
                      //     Center(
                      //       child: SvgPicture.asset(
                      //         "assets/icons/facebook_icon.svg",
                      //         width: fullHeight * 0.028,
                      //         height: fullHeight * 0.028,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ).paddingSymmetric(vertical: fullHeight * 0.01),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MainText(
                    text: 'Don\'t have an account?',
                    textAlign: TextAlign.center,
                    fontSize: 15,
                    color: AppColors.lightText,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(width: fullWidth * 0.02),
                  InkWell(
                    onTap: () {
                      BottomNavigationBarController cont = Get.find();
                      cont.isLogin.value = false;

                      cont.changelogin();
                      // Get.offAll(() => SignupView(), binding: SignUpBinding());
                    },
                    child: MainText(
                      text: 'Sign Up'.tr,
                      textAlign: TextAlign.center,
                      fontSize: 15,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ).paddingOnly(top: fullHeight * 0.04),
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
