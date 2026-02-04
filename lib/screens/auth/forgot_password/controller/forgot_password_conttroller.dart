import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/auth/forgot_password/provider/forgot_password_provider.dart';
import 'package:jovera_finance/screens/auth/forgot_password/view/create_new_password_view.dart';
import 'package:jovera_finance/screens/auth/forgot_password/view/password_reset_successful_view.dart';
import 'package:jovera_finance/screens/auth/forgot_password/view/verify_otp_view.dart';
import 'package:jovera_finance/screens/auth/login/model/users.dart';
import 'package:jovera_finance/screens/auth/signup/provider/signup_provider.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/view/bottom_navigation_bar_view.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/constants/app_tools.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';
import 'package:jovera_finance/widgets/app_loading_controller.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';

class ForgotPasswordState {
  const ForgotPasswordState({
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.otpController,
    required this.appLoadingController,
    this.passwordIsVisible = false,
    this.otp = '',
    this.resetPasswordToken = '',
    this.confirmPasswordIsVisible = false,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController otpController;
  final AppLoadingController appLoadingController;
  final bool passwordIsVisible;
  final String otp;
  final String resetPasswordToken;
  final bool confirmPasswordIsVisible;

  ForgotPasswordState copyWith({
    bool? passwordIsVisible,
    String? otp,
    String? resetPasswordToken,
    bool? confirmPasswordIsVisible,
  }) {
    return ForgotPasswordState(
      emailController: emailController,
      passwordController: passwordController,
      confirmPasswordController: confirmPasswordController,
      otpController: otpController,
      appLoadingController: appLoadingController,
      passwordIsVisible: passwordIsVisible ?? this.passwordIsVisible,
      otp: otp ?? this.otp,
      resetPasswordToken: resetPasswordToken ?? this.resetPasswordToken,
      confirmPasswordIsVisible:
          confirmPasswordIsVisible ?? this.confirmPasswordIsVisible,
    );
  }
}

class ForgotPasswordController extends StateNotifier<ForgotPasswordState> {
  ForgotPasswordController(this.ref)
    : super(
        ForgotPasswordState(
          emailController: TextEditingController(),
          passwordController: TextEditingController(),
          confirmPasswordController: TextEditingController(),
          otpController: TextEditingController(),
          appLoadingController: AppLoadingController(),
        ),
      );

  final Ref ref;

  TextEditingController get emailController => state.emailController;
  TextEditingController get passwordController => state.passwordController;
  TextEditingController get confirmPasswordController =>
      state.confirmPasswordController;
  TextEditingController get otpController => state.otpController;
  AppLoadingController get appLoadingController => state.appLoadingController;
  bool get passwordIsVisible => state.passwordIsVisible;
  String get otp => state.otp;
  String get resetPasswordToken => state.resetPasswordToken;
  bool get confirmPasswordIsVisible => state.confirmPasswordIsVisible;

  set passwordIsVisible(bool value) {
    state = state.copyWith(passwordIsVisible: value);
  }

  set otp(String value) {
    state = state.copyWith(otp: value);
  }

  set resetPasswordToken(String value) {
    state = state.copyWith(resetPasswordToken: value);
  }

  set confirmPasswordIsVisible(bool value) {
    state = state.copyWith(confirmPasswordIsVisible: value);
  }
  Future<void> forgotPassword() async {
    appLoadingController.loading();
    ForgotPasswordProvider().forgotPassword(
      email: emailController.text,

      onSuccess: (response) {
        appLoadingController.stop();
        if (kDebugMode) print(response); // if (response.data is String) {
        //   final Map<String, dynamic> responseData = json.decode(response.data);
        //   authManager.appUser.value = AppUser.fromJson(responseData['user']);
        // } else if (response.data is Map<String, dynamic>) {
        //   authManager.appUser.value = AppUser.fromJson(response.data['user']);
        // }

        appTools.showSuccessSnackBar(
          "OTP sent to your email address. Please verify",
        );

        AppNavigator.push(VerifyOtpView());
      },
      onError: (error) {
        if (kDebugMode) print(error.message);
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
      email: emailController.text,
      otp: otpController.text,

      onSuccess: (response) {
        appLoadingController.stop();
        resetPasswordToken = json.decode(response.data)['resetPasswordToken'];

        appTools.showSuccessSnackBar("Successful. OTP verified.");
        AppNavigator.pushReplacement(CreateNewPasswordView());
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
    if (passwordController.text == confirmPasswordController.text) {
      appLoadingController.loading();
      ForgotPasswordProvider().createNewPassword(
        email: emailController.text,
        newPassword: passwordController.text,
        resetPasswordToken: resetPasswordToken,

        onSuccess: (response) {
          appLoadingController.stop();
          appTools.showSuccessSnackBar("Password Reset Successful.");

          AppNavigator.pushReplacement(PasswordResetSuccessfulView());
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
      email: emailController.text,
      password: passwordController.text,

      onSuccess: (response) {
        appLoadingController.stop();
        if (kDebugMode) print(response);
        if (response.data is String) {
          final Map<String, dynamic> responseData = json.decode(response.data);
          ref
              .read(authManagerProvider.notifier)
              .setUser(AppUser.fromJson(responseData));
        } else if (response.data is Map<String, dynamic>) {
          ref
              .read(authManagerProvider.notifier)
              .setUser(AppUser.fromJson(response.data));
        }
        ref.read(authManagerProvider.notifier).login();
        emailController.clear();
        passwordController.clear();

        appTools.showSuccessSnackBar(
          "Congratulation.Your account is ready to use.".tr,
        );
        AppNavigator.pushAndRemoveUntil(BottomnavigationBarView());
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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    otpController.dispose();
    appLoadingController.dispose();
    super.dispose();
  }
}

final forgotPasswordControllerProvider =
    StateNotifierProvider<ForgotPasswordController, ForgotPasswordState>((ref) {
  return ForgotPasswordController(ref);
});
