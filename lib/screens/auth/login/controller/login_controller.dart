import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/auth/login/model/users.dart';
import 'package:jovera_finance/screens/auth/login/provider/login_provider.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/view/bottom_navigation_bar_view.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/constants/app_tools.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';
import 'package:jovera_finance/widgets/app_loading_controller.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';

class LoginState {
  const LoginState({
    required this.passwordController,
    required this.emailController,
    required this.auth,
    required this.appLoadingController,
    this.passwordIsVisible = false,
    this.keepSignIn = false,
    this.googleApiKey = '',
  });

  final TextEditingController passwordController;
  final TextEditingController emailController;
  final bool passwordIsVisible;
  final FirebaseAuth auth;
  final AppLoadingController appLoadingController;
  final bool keepSignIn;
  final String googleApiKey;

  LoginState copyWith({
    bool? passwordIsVisible,
    bool? keepSignIn,
    String? googleApiKey,
  }) {
    return LoginState(
      passwordController: passwordController,
      emailController: emailController,
      auth: auth,
      appLoadingController: appLoadingController,
      passwordIsVisible: passwordIsVisible ?? this.passwordIsVisible,
      keepSignIn: keepSignIn ?? this.keepSignIn,
      googleApiKey: googleApiKey ?? this.googleApiKey,
    );
  }
}

class LoginController extends StateNotifier<LoginState> {
  LoginController(this.ref)
    : super(
        LoginState(
          passwordController: TextEditingController(),
          emailController: TextEditingController(),
          auth: FirebaseAuth.instance,
          appLoadingController: AppLoadingController(),
        ),
      ) {
    getToken();
  }

  final Ref ref;

  TextEditingController get passwordController => state.passwordController;
  TextEditingController get emailController => state.emailController;
  FirebaseAuth get auth => state.auth;
  AppLoadingController get appLoadingController => state.appLoadingController;
  bool get passwordIsVisible => state.passwordIsVisible;
  bool get keepSignIn => state.keepSignIn;
  String get googleApiKey => state.googleApiKey;

  set passwordIsVisible(bool value) {
    state = state.copyWith(passwordIsVisible: value);
  }

  set keepSignIn(bool value) {
    state = state.copyWith(keepSignIn: value);
  }

  set googleApiKey(String value) {
    state = state.copyWith(googleApiKey: value);
  }

  void getToken() async {
    debugPrint(await appTools.getFCMTokenForDevice());
  }

  Future<void> login() async {
    final String? fcmToken = await appTools.getFCMTokenForDevice();
    debugPrint(fcmToken.toString());
    appLoadingController.loading();
    LoginProvider().login(
      email: emailController.text,
      password: passwordController.text,
      fcm: fcmToken,

      onSuccess: (response) {
        appLoadingController.stop();
      //  print(response);
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
        ref
            .read(bottomNavigationBarControllerProvider.notifier)
            .onItemTapped(0);
        emailController.clear();
        passwordController.clear();

        appTools.showSuccessSnackBar(
          "Congratulations. Your account is ready to use.".tr,
        );
        AppNavigator.pushAndRemoveUntil(BottomnavigationBarView());
      },
      onError: (error) {
        appLoadingController.stop();
        if (kDebugMode) print(error.response);
        appTools.showErrorSnackBar(
          appTools.errorMessage(error) ??
              'Opps, something went wrong. Please check you internet connection.',
          timer: 1,
        );
      },
    );
  }

  Future<void> loginByGoogle(String idToken) async {
    final String? fcmToken = await appTools.getFCMTokenForDevice();
    debugPrint(fcmToken.toString());
    debugPrint("*****************");
    debugPrint(idToken);
    appLoadingController.loading();
    LoginProvider().loginByGoogle(
      token: idToken, //googleApiKey.value,
      fcmToken: fcmToken,

      onSuccess: (response) async {
        appLoadingController.stop();
        debugPrint(response.toString());
        if (response.data is String) {
          final Map<String, dynamic> responseData = json.decode(response.data);
          ref
              .read(authManagerProvider.notifier)
              .setUser(AppUser.fromJson(responseData['user']));
        } else if (response.data is Map<String, dynamic>) {
          ref
              .read(authManagerProvider.notifier)
              .setUser(AppUser.fromJson(response.data['user']));
        }
        ref.read(authManagerProvider.notifier).login();
        ref
            .read(bottomNavigationBarControllerProvider.notifier)
            .onItemTapped(0);

        appTools.showSuccessSnackBar("You're in! Login successful.".tr);

        AppNavigator.pushAndRemoveUntil(BottomnavigationBarView());
      },
      onError: (error) {
        appLoadingController.stop();
        appTools.showErrorSnackBar('Error'.tr, timer: 1);
      },
    );
  }

  Future<void> handleGoogleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        if (FirebaseAuth.instance.currentUser != null) {
          handleGoogleSignOut();
        }

        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        debugPrint(googleSignInAuthentication.accessToken);
        await auth.signInWithCredential(credential);
        User? firebaseUser = FirebaseAuth.instance.currentUser;

        if (firebaseUser != null) {
          await loginByGoogle(googleSignInAuthentication.idToken!);
          debugPrint('00000000000000000000000000000009');

          debugPrint('Google Sign-In successful');
        }
      }
    } catch (e) {
      debugPrint('Google Sign-In error: $e');
    }
  }

  Future<void> handleGoogleSignOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
    googleApiKey = '';
    debugPrint('Google Sign-Out successful'.tr);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    appLoadingController.dispose();
    super.dispose();
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>((ref) {
  return LoginController(ref);
});
