import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jovera_finance/screens/bottom_navigation/calculator/controller/calculator_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('CalculatorController starts with expected services', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final state = container.read(calculatorControllerProvider);
    expect(state.selectedService, 0);
    expect(state.servicesList.length, 4);
    expect(state.servicesList[0].title, 'Mortgage');
    expect(state.servicesList[1].title, 'Personal Loan');
    expect(state.servicesList[2].title, 'Business Loan');
    expect(state.servicesList[3].title, 'Car Loan');
  });

  test('CalculatorController updates selectedService', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final controller = container.read(calculatorControllerProvider.notifier);
    controller.selectedService = 2;

    expect(container.read(calculatorControllerProvider).selectedService, 2);
  });
}
