import 'package:get/get.dart';
import 'package:jovera_finance/screens/mortgage/controller/mortgage_controller.dart';

class MortgageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MortgageController>(() => MortgageController());
  }
}
