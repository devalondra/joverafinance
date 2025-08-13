import 'package:get/get.dart';
import 'package:jovera_finance/screens/auth/language/controller/language_controller.dart';
import 'package:jovera_finance/screens/auth/login/controller/login_controller.dart';
import 'package:jovera_finance/screens/auth/signup/controller/signup_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/calculator/controller/calculator_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/home/controller/home_controller.dart';

class BottomNavigationBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavigationBarController>(
      () => BottomNavigationBarController(),
    );
    Get.lazyPut<LanguageController>(() => LanguageController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CalculatorController>(() => CalculatorController());

    Get.lazyPut<SignUpController>(() => SignUpController());

    Get.lazyPut<LoginController>(() => LoginController());
  }
}
