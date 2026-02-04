import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/bottom_navigation/home/model/main_service_model.dart';
import 'package:jovera_finance/screens/business_loan/view/business_loan_landing_view.dart';
import 'package:jovera_finance/screens/mortgage/common/mortgage_landing_view.dart';
import 'package:jovera_finance/screens/personal_loan/view/personal_loan_landing_view.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';

class ServicesState {
  const ServicesState({
    required this.servicesList,
    this.selectedService = 0,
  });

  final int selectedService;
  final List<MainServiceModel> servicesList;

  ServicesState copyWith({
    int? selectedService,
    List<MainServiceModel>? servicesList,
  }) {
    return ServicesState(
      servicesList: servicesList ?? this.servicesList,
      selectedService: selectedService ?? this.selectedService,
    );
  }
}

class ServicesController extends StateNotifier<ServicesState> {
  ServicesController(this.ref)
    : super(
        ServicesState(
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
        ),
      );

  final Ref ref;

  int get selectedService => state.selectedService;
  List<MainServiceModel> get servicesList => state.servicesList;

  set selectedService(int value) {
    state = state.copyWith(selectedService: value);
  }

}

final servicesControllerProvider =
    StateNotifierProvider<ServicesController, ServicesState>((ref) {
  return ServicesController(ref);
});
