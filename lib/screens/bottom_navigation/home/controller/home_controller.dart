import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/home/model/main_service_model.dart';
import 'package:jovera_finance/screens/mortgage/mortgage_apply/view/mortgage_information_view.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/widgets/app_loading_controller.dart';

class HomeController extends GetxController {
  late PageController pageController;
  var selectedDate = DateTime.now().obs;

  RxInt currentPage = 0.obs;
  AuthManager authManager = Get.find();
  AppLoadingController appLoadingController = AppLoadingController();

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

  List<MainServiceModel> servicesList = <MainServiceModel>[
    MainServiceModel(
      id: 1,
      title: "Mortgage".tr,
      iconPath: "assets/icons/mortgage_icon.svg",
      onTap: () {
        Get.to(() => MortgageInformationView());
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

  void onPageChanged(int index) {
    currentPage.value = index;
    update();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  List offersCarouselList = [
    "assets/images/carousal_image.png",
    "assets/images/carousal_image.png",
    "assets/images/carousal_image.png",
  ];
}
