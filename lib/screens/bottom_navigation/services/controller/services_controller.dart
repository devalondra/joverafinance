import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/home/model/main_service_model.dart';
import 'package:jovera_finance/screens/mortgage/binding/mortgage_binding.dart';
import 'package:jovera_finance/screens/mortgage/controller/mortgage_controller.dart';
import 'package:jovera_finance/screens/mortgage/mortgage_apply/view/mortgage_information_view.dart';

class ServicesController extends GetxController {
  List<MainServiceModel> servicesList = <MainServiceModel>[
    MainServiceModel(
      id: 1,
      title: "Mortgage".tr,
      iconPath: "assets/icons/mortgage_icon.svg",
      onTap: () {
        Get.lazyPut<MortgageController>(() => MortgageController());
        Get.to(() => MortgageInformationView(), binding: MortgageBinding());
      },
    ),
    MainServiceModel(
      id: 2,
      title: "Personal Loan".tr,
      iconPath: "assets/icons/personal_loan_icon.svg",
      onTap: () {
        Get.to(() => MortgageInformationView());
      },
    ),
    MainServiceModel(
      id: 3,
      title: "Business Loan".tr,
      iconPath: "assets/icons/mortgage_icon.svg",
      onTap: () {
        Get.to(() => MortgageInformationView());
      },
    ),
    MainServiceModel(
      id: 4,
      title: "Car Loan".tr,
      iconPath: "assets/icons/personal_loan_icon.svg",
      onTap: () {
        Get.to(() => MortgageInformationView());
      },
    ),
  ];
}
