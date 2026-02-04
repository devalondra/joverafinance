import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/bottom_navigation/home/model/main_service_model.dart';
import 'package:jovera_finance/screens/business_loan/view/business_loan_landing_view.dart';
import 'package:jovera_finance/screens/mortgage/common/mortgage_landing_view.dart';
import 'package:jovera_finance/screens/personal_loan/view/personal_loan_landing_view.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/widgets/app_loading_controller.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';

class HomeState {
   HomeState({
    required this.pageController,
    required this.appLoadingController,
    required this.servicesList,
    required this.offersCarouselList,
    DateTime? selectedDate,
    this.selectedService = 0,
    this.currentPage = 0,
  }) : selectedDate = selectedDate ?? DateTime.now();

  final PageController pageController;
  final DateTime selectedDate;
  final int selectedService;
  final int currentPage;
  final AppLoadingController appLoadingController;
  final List<MainServiceModel> servicesList;
  final List offersCarouselList;

  HomeState copyWith({
    DateTime? selectedDate,
    int? selectedService,
    int? currentPage,
    List<MainServiceModel>? servicesList,
    List? offersCarouselList,
  }) {
    return HomeState(
      pageController: pageController,
      appLoadingController: appLoadingController,
      servicesList: servicesList ?? this.servicesList,
      offersCarouselList: offersCarouselList ?? this.offersCarouselList,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedService: selectedService ?? this.selectedService,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class HomeController extends StateNotifier<HomeState> {
  HomeController(this.ref)
    : super(
        HomeState(
          pageController: PageController(),
          appLoadingController: AppLoadingController(),
          servicesList: <MainServiceModel>[
            MainServiceModel(
              id: 1,
              title: "Mortgage".tr,
              iconPath: "assets/icons/mortgage_icon.svg",
              onTap: () {
                AppNavigator.push(MortgageLandingView());
              },
            ),
            MainServiceModel(
              id: 2,
              title: "Personal Loan".tr,
              iconPath: "assets/icons/personal_loan_icon.svg",
              onTap: () {
                AppNavigator.push(PersonalLoanLandingView());
              },
            ),
            MainServiceModel(
              id: 3,
              title: "Business Loan".tr,
              iconPath: "assets/icons/business_loan_icon.svg",
              onTap: () {
                AppNavigator.push(BusinessLoanLandingView());
              },
            ),
            MainServiceModel(
              id: 4,
              title: "Car Loan".tr,
              iconPath: "assets/icons/car_loan_icon.svg",
              onTap: () {
                AppNavigator.push(BusinessLoanLandingView());
              },
            ),
          ],
          offersCarouselList: [
            "assets/images/carousal_image.png",
            "assets/images/carousal_image.png",
            "assets/images/carousal_image.png",
          ],
        ),
      );

  final Ref ref;
  PageController get pageController => state.pageController;
  DateTime get selectedDate => state.selectedDate;
  int get selectedService => state.selectedService;
  int get currentPage => state.currentPage;
  AppLoadingController get appLoadingController => state.appLoadingController;
  List<MainServiceModel> get servicesList => state.servicesList;
  List get offersCarouselList => state.offersCarouselList;

  set selectedDate(DateTime value) {
    state = state.copyWith(selectedDate: value);
  }

  set selectedService(int value) {
    state = state.copyWith(selectedService: value);
  }

  void onPageChanged(int index) {
    state = state.copyWith(currentPage: index);
  }

  @override
  void dispose() {
    pageController.dispose();
    appLoadingController.dispose();
    super.dispose();
  }

  bool checkLoginStatus() {
    return ref.read(authManagerProvider).isLogged;
  }
}

final homeControllerProvider =
    StateNotifierProvider<HomeController, HomeState>((ref) {
  return HomeController(ref);
});
