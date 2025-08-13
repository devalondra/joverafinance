import 'package:get/get.dart';
import 'package:jovera_finance/screens/auth/splash/controller/splash_controller.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<AuthManager>(() => AuthManager());
  }
}
