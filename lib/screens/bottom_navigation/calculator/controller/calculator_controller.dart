import 'package:get/get.dart';

import 'package:jovera_finance/screens/bottom_navigation/home/model/main_service_model.dart';
import 'package:jovera_finance/screens/business_loan/calculator/business_loan_calculator_view.dart';
import 'package:jovera_finance/screens/mortgage/calculator/mortgage_calculator_view.dart';
import 'package:jovera_finance/screens/mortgage/controller/mortgage_controller.dart';
import 'package:jovera_finance/screens/personal_loan/binding/personal_loan_binding.dart';
import 'package:jovera_finance/screens/personal_loan/view/personal_loan_apply_as_view.dart';
import 'package:jovera_finance/screens/personal_loan/controller/personal_loan_controller.dart';
import 'package:jovera_finance/screens/business_loan/binding/business_loan_binding.dart';
import 'package:jovera_finance/screens/business_loan/controller/business_loan_controller.dart';

class CalculatorController extends GetxController {
  RxInt selectedService = 0.obs;
  List<MainServiceModel> servicesList = <MainServiceModel>[
    MainServiceModel(
      id: 1,
      title: "Mortgage".tr,
      iconPath: "assets/icons/mortgage_icon.svg",
      onTap: () {
        Get.lazyPut<MortgageController>(() => MortgageController());
        Get.to(() => MortgageCalculatorView());
      },
    ),
    MainServiceModel(
      id: 2,
      title: "Personal Loan".tr,
      iconPath: "assets/icons/personal_loan_icon.svg",
      onTap: () {
        Get.lazyPut<PersonalLoanController>(() => PersonalLoanController());
        Get.to(() => PersonalLoanApplyAsView(), binding: PersonalLoanBinding());
      },
    ),
    MainServiceModel(
      id: 3,
      title: "Business Loan".tr,
      iconPath: "assets/icons/business_loan_icon.svg",
      onTap: () {
        Get.lazyPut<BusinessLoanController>(() => BusinessLoanController());
        Get.to(
          () => BusinessLoanCalculatorView(),
          binding: BusinessLoanBinding(),
        );
      },
    ),
    MainServiceModel(
      id: 4,
      title: "Car Loan".tr,
      iconPath: "assets/icons/car_loan_icon.svg",
      onTap: () {
        Get.lazyPut<BusinessLoanController>(() => BusinessLoanController());
        Get.to(
          () => BusinessLoanCalculatorView(),
          binding: BusinessLoanBinding(),
        );
      },
    ),
  ];
}
