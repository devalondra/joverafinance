import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/auth/forgot_password/provider/forgot_password_provider.dart';
import 'package:jovera_finance/screens/auth/forgot_password/view/create_new_password_view.dart';
import 'package:jovera_finance/screens/auth/forgot_password/view/password_reset_successful_view.dart';
import 'package:jovera_finance/screens/auth/forgot_password/view/verify_otp_view.dart';
import 'package:jovera_finance/screens/auth/login/model/users.dart';
import 'package:jovera_finance/screens/auth/signup/provider/signup_provider.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/binding/bottom_navigation_bar_binding.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/view/bottom_navigation_bar_view.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/widgets/app_loading_controller.dart';

class ForgotPasswordController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController =
      TextEditingController().obs;
  Rx<TextEditingController> otpController = TextEditingController().obs;
  final AuthManager authManager = Get.find();
  AppLoadingController appLoadingController = AppLoadingController();
  RxBool passwordIsVisible = false.obs;
  RxString otp = ''.obs;
  RxString resetPasswordToken = ''.obs;
  RxBool confirmPasswordIsVisible = false.obs;
  Future<void> forgotPassword() async {
    appLoadingController.loading();
    ForgotPasswordProvider().forgotPassword(
      email: emailController.value.text,

      onSuccess: (response) {
        appLoadingController.stop();
        print(response); // if (response.data is String) {
        //   final Map<String, dynamic> responseData = json.decode(response.data);
        //   authManager.appUser.value = AppUser.fromJson(responseData['user']);
        // } else if (response.data is Map<String, dynamic>) {
        //   authManager.appUser.value = AppUser.fromJson(response.data['user']);
        // }

        appTools.showSuccessSnackBar(
          "OTP sent to your email address. Please verify",
        );

        Get.to(() => VerifyOtpView());
      },
      onError: (error) {
        print(error.message);
        appLoadingController.stop();
        appTools.showErrorSnackBar(
          appTools.errorMessage(error) ??
              'Opps, an error occurred during registration, Please try again later',
          timer: 1,
        );
      },
    );
  }

  Future<void> verifyOtp() async {
    appLoadingController.loading();
    ForgotPasswordProvider().verifyOtp(
      email: emailController.value.text,
      otp: otpController.value.text,

      onSuccess: (response) {
        appLoadingController.stop();
        resetPasswordToken.value =
            json.decode(response.data)['resetPasswordToken'];

        appTools.showSuccessSnackBar("Successful. OTP verified.");
        Get.off(() => CreateNewPasswordView());
      },
      onError: (error) {
        appLoadingController.stop();
        appTools.showErrorSnackBar(
          appTools.errorMessage(error) ??
              'Opps, an error occurred during registration, Please try again later',
          timer: 1,
        );
      },
    );
  }

  Future<void> createNewPassword() async {
    if (passwordController.value.text == confirmPasswordController.value.text) {
      appLoadingController.loading();
      ForgotPasswordProvider().createNewPassword(
        email: emailController.value.text,
        newPassword: passwordController.value.text,
        resetPasswordToken: resetPasswordToken.value,

        onSuccess: (response) {
          appLoadingController.stop();
          appTools.showSuccessSnackBar("Password Reset Successful.");

          Get.off(() => PasswordResetSuccessfulView());
        },
        onError: (error) {
          appLoadingController.stop();
          appTools.showErrorSnackBar(
            appTools.errorMessage(error) ??
                'Opps, an error occurred during registration, Please try again later',
            timer: 1,
          );
        },
      );
    } else {
      appTools.showWarningSnackBar("Passwords do not match");
    }
  }

  Future<void> secretLogin() async {
    appLoadingController.loading();
    SignupProvider().secretLogin(
      email: emailController.value.text,
      password: passwordController.value.text,

      onSuccess: (response) {
        appLoadingController.stop();
        print(response);
        if (response.data is String) {
          final Map<String, dynamic> responseData = json.decode(response.data);
          authManager.appUser.value = AppUser.fromJson(responseData);
        } else if (response.data is Map<String, dynamic>) {
          authManager.appUser.value = AppUser.fromJson(response.data);
        }
        authManager.login();
        emailController.value.clear();
        passwordController.value.clear();

        appTools.showSuccessSnackBar(
          "Congratulation.Your account is ready to use.".tr,
        );
        Get.offAll(
          () => BottomnavigationBarView(),
          binding: BottomNavigationBarBinding(),
        );
      },
      onError: (error) {
        appLoadingController.stop();
        appTools.showErrorSnackBar(
          appTools.errorMessage(error) ??
              'Opps, an error occurred during registration, Please try again later',
          timer: 1,
        );
      },
    );
  }
}
