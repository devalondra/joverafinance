import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/auth/login/controller/login_controller.dart';
import 'package:jovera_finance/screens/auth/login/view/login_view.dart';
import 'package:jovera_finance/screens/auth/signup/controller/signup_controller.dart';
import 'package:jovera_finance/screens/auth/signup/view/signup_view.dart';
import 'package:jovera_finance/screens/bottom_navigation/calculator/view/calculator_view.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/view/chat_view.dart';
import 'package:jovera_finance/screens/bottom_navigation/home/view/home_view.dart';
import 'package:jovera_finance/screens/bottom_navigation/services/view/services_view.dart';

import 'package:jovera_finance/utilities/authentication/auth_manager.dart';

class BottomNavigationBarController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxInt selectedHomeSubPage = 0.obs;
  RxBool isLogin = true.obs;

  AuthManager authManager = Get.find();

  RxList<Widget> widgetOptions = <Widget>[].obs;
  @override
  onInit() {
    super.onInit();
    widgetOptions.value = <Widget>[
      const HomeView(),
      loggedIn()
          ? const ServicesView()
          : isLogin.value
          ? LoginView()
          : SignupView(),
      loggedIn()
          ? const CalculatorView()
          : isLogin.value
          ? LoginView()
          : SignupView(),
      loggedIn()
          ? const ChatView()
          : isLogin.value
          ? LoginView()
          : SignupView(),

      const ChatView(),
    ];
  }

  bool loggedIn() {
    if (authManager.isLogged.value) {
      return true;
    } else {
      Get.lazyPut<LoginController>(() => LoginController());
      Get.lazyPut<SignUpController>(() => SignUpController());
      return false;
    }
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  void changelogin() {
    widgetOptions.value = <Widget>[
      const HomeView(),
      loggedIn()
          ? const ServicesView()
          : isLogin.value
          ? LoginView()
          : SignupView(),
      loggedIn()
          ? const CalculatorView()
          : isLogin.value
          ? LoginView()
          : SignupView(),
      loggedIn()
          ? const ChatView()
          : isLogin.value
          ? LoginView()
          : SignupView(),
      const ChatView(),
    ];
    widgetOptions.refresh();
  }
}
