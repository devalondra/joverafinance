import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/auth/login/model/users.dart';
import 'package:jovera_finance/screens/auth/login/provider/login_provider.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/binding/bottom_navigation_bar_binding.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/view/bottom_navigation_bar_view.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/constants/app_tools.dart';
import 'package:jovera_finance/widgets/app_loading_controller.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  RxBool passwordIsVisible = false.obs;
  final AuthManager authManager = Get.find();
  final FirebaseAuth auth = FirebaseAuth.instance;
  AppLoadingController appLoadingController = AppLoadingController();
  RxBool keepSignIn = false.obs;
  AppTools appTools = AppTools();
  RxString googleApiKey = ''.obs;
  @override
  void onInit() {
    getToken();
    super.onInit();
  }

  void getToken() async {
    debugPrint(await appTools.getFCMTokenForDevice());
  }

  Future<void> login() async {
    final String? fcmToken = await appTools.getFCMTokenForDevice();
    debugPrint(fcmToken.toString());
    appLoadingController.loading();
    LoginProvider().login(
      email: emailController.value.text,
      password: passwordController.value.text,
      fcm: fcmToken,

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
          "Congratulations. Your account is ready to use.".tr,
        );
        Get.offAll(
          () => BottomnavigationBarView(),
          binding: BottomNavigationBarBinding(),
        );
        debugPrint(response.toString());
      },
      onError: (error) {
        appLoadingController.stop();
        print(error.response);
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
          authManager.appUser.value = AppUser.fromJson(responseData['user']);
        } else if (response.data is Map<String, dynamic>) {
          authManager.appUser.value = AppUser.fromJson(response.data['user']);
        }
        authManager.login();

        appTools.showSuccessSnackBar("You're in! Login successful.".tr);

        Get.offAll(
          () => BottomnavigationBarView(),
          binding: BottomNavigationBarBinding(),
        );
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
    googleApiKey.value = '';
    debugPrint('Google Sign-Out successful'.tr);
  }
}
