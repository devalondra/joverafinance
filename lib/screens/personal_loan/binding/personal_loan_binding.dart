import 'package:get/get.dart';
import 'package:jovera_finance/screens/personal_loan/controller/personal_loan_controller.dart';

class PersonalLoanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalLoanController>(() => PersonalLoanController());
  }
}
