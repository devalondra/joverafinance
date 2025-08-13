import 'package:get/get.dart';
import 'package:jovera_finance/screens/auth/language/controller/language_controller.dart';

class LanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LanguageController>(() => LanguageController());
  }
}
