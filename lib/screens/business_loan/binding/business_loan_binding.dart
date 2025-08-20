import 'package:get/get.dart';
import 'package:jovera_finance/screens/business_loan/controller/business_loan_controller.dart';

class BusinessLoanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BusinessLoanController>(() => BusinessLoanController());
  }
}
