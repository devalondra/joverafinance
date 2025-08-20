import 'package:get/get.dart';
import 'package:jovera_finance/screens/main_drawer/notification/controller/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}
