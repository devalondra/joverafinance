import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:jovera_finance/screens/bottom_navigation/home/model/main_service_model.dart';
import 'package:jovera_finance/screens/business_loan/calculator/business_loan_calculator_view.dart';
import 'package:jovera_finance/screens/mortgage/calculator/mortgage_calculator_view.dart';
import 'package:jovera_finance/screens/personal_loan/view/personal_loan_apply_as_view.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';

class CalculatorState {
  const CalculatorState({
    required this.servicesList,
    this.selectedService = 0,
  });

  final int selectedService;
  final List<MainServiceModel> servicesList;

  CalculatorState copyWith({
    int? selectedService,
    List<MainServiceModel>? servicesList,
  }) {
    return CalculatorState(
      servicesList: servicesList ?? this.servicesList,
      selectedService: selectedService ?? this.selectedService,
    );
  }
}

class CalculatorController extends StateNotifier<CalculatorState> {
  CalculatorController(this.ref)
    : super(
        CalculatorState(
          servicesList: <MainServiceModel>[
            MainServiceModel(
              id: 1,
              title: "Mortgage".tr,
              iconPath: "assets/icons/mortgage_icon.svg",
              onTap: () {
                AppNavigator.push(MortgageCalculatorView());
              },
            ),
            MainServiceModel(
              id: 2,
              title: "Personal Loan".tr,
              iconPath: "assets/icons/personal_loan_icon.svg",
              onTap: () {
                AppNavigator.push(PersonalLoanApplyAsView());
              },
            ),
            MainServiceModel(
              id: 3,
              title: "Business Loan".tr,
              iconPath: "assets/icons/business_loan_icon.svg",
              onTap: () {
                AppNavigator.push(BusinessLoanCalculatorView());
              },
            ),
            MainServiceModel(
              id: 4,
              title: "Car Loan".tr,
              iconPath: "assets/icons/car_loan_icon.svg",
              onTap: () {
                AppNavigator.push(BusinessLoanCalculatorView());
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

final calculatorControllerProvider =
    StateNotifierProvider<CalculatorController, CalculatorState>((ref) {
  return CalculatorController(ref);
});
