import 'package:get/get.dart';

import 'package:jovera_finance/screens/bottom_navigation/calculator/controller/calculator_controller.dart';

class CalculatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalculatorController>(() => CalculatorController());
  }
}
