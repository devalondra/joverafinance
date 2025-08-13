import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/controller/chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController());
  }
}
