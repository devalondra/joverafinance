import 'package:get/get.dart';
import 'package:jovera_finance/screens/auth/login/controller/login_controller.dart';
import 'package:jovera_finance/screens/auth/signup/controller/signup_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/calculator/controller/calculator_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/controller/chat_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/home/controller/home_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/services/controller/services_controller.dart';

class BottomNavigationBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavigationBarController>(
      () => BottomNavigationBarController(),
    );
    Get.lazyPut<ServicesController>(() => ServicesController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CalculatorController>(() => CalculatorController());

    Get.lazyPut<SignUpController>(() => SignUpController());
    Get.lazyPut<ChatController>(() => ChatController());

    Get.lazyPut<LoginController>(() => LoginController());
  }
}
