import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/services/controller/services_controller.dart';

class ServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServicesController>(() => ServicesController());
  }
}
