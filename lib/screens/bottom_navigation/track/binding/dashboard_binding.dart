import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/track/controller/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    
  }
}
