import 'package:get/get.dart';
import 'package:jovera_finance/screens/auth/app_permissions/controller/app_permissions_controller.dart';

class AppPermissionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppPermissionsController>(() => AppPermissionsController());
  }
}
