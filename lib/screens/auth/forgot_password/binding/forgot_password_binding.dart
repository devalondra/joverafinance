import 'package:get/get.dart';
import 'package:jovera_finance/screens/auth/forgot_password/controller/forgot_password_conttroller.dart';

class ForgotpasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
  }
}
